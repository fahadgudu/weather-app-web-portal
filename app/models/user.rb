class User < ActiveRecord::Base

  geocoded_by :address
  after_validation :geocode          # auto-fetch coordinates

  def send_sms
    begin
      account_sid = Rails.application.secrets.twilio['account_sid']
      auth_token = Rails.application.secrets.twilio['auth_token']
      number = Rails.application.secrets.twilio['number']
      @client = Twilio::REST::Client.new account_sid, auth_token
      user = self.mobile_number
      user = self
      lat, long = user.latitude, user.longitude
      @weather_data = user.get_weather_data(lat, long)
      @client.account.messages.create({:from => number, :to => user, :body => @weather_data})
    rescue StandardError => ex
      Rails.logger.error "#{ex.message}"
    end
  end

  def get_weather_data(lat = nil, long = nil)
      ForecastIO.api_key = '19b2f7931e74fa8fbfd9c0c8e9f79937'
      forecast = ForecastIO.forecast(lat, long)
      build_response(forecast)
  end

  def build_response(response)
    body = parse_response(response) || {}
    response_hash = { body: body, status_code: 200 }
    case response.code
      when 200
        response_hash[:response] = 'success'
        body = JSON.parse(body) unless body.empty?
        response_hash = body
      when 400
        response_hash[:response] = 'Only applies for JSON requests. Indicates that the request could not be parsed as JSON, or it contained invalid fields.'
      when 401
        response_hash[:response] = 'There was an error authenticating the sender account.'
      when 503
        response_hash[:response] = 'Server is temporarily unavailable.'
      when 500..599
        response_hash[:response] = 'There was an internal error in the SWIFT ENTERTAINMENT server while trying to process the request.'
    end
    response_hash
  end

  def full_name
    first_name || email
  end

  def name
    first_name || email
  end

  def parse_response(response)
    json_parse = {}
    unless response.empty?
      json_parse['i'] = encode_weather(response.currently)
      daily_data = Array.new(0)
      if response.daily.data.count > 0
        (response.daily.data).each_with_index { |day,index|
          json_parse[index] = encode_weather(day)
          daily_data << json_parse[index]
      }
      end
    end
    json_parse
  end

  def encode_weather(data)
    w_hash = Hash.new(0)
    w_hash[:s] =  data.summary rescue ''
    w_hash[:i] =  icon_translate(data.icon) rescue ''
    w_hash[:c] =  data.precipIntensity rescue ''
    w_hash[:p] =  ((data.precipProbability) * 100).to_i rescue ''
    w_hash[:t] =  change_to_celcuis(data.temperature) rescue ''
    w_hash[:x] =  change_to_celcuis(data.apparentTemperatureMax) rescue ''
    w_hash[:m] =  change_to_celcuis(data.apparentTemperatureMin) rescue ''
    w_hash[:h] =  data.humidity rescue ''
    w_hash[:w] =  data.windSpeed rescue ''
    w_hash[:b] =  data.windBearing rescue ''
    w_hash
  end

  def change_to_celcuis(temperature)
    ((temperature - 32) * 5.0 / 9.0).ceil
  end

  def icon_translate(icon)
    icons = ['clear-day', 'clear-night', 'rain', 'snow', 'sleet', 'wind', 'fog', 'cloudy', 'partly-cloudy-day','partly-cloudy-night','hail', 'thunderstorm','tornado']
    idx = icons.index{|s| s.include?(icon)}
    idx
  end

end
