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
    response_hash = body
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
    json_parse = []
    unless response.empty?
      json_parse << encode_weather(response.currently)
      if response.daily.data.count > 0
        (response.daily.data).each_with_index { |day,index|
          json_parse <<  encode_weather(day)
      }
      end
    end
    json_parse
  end

  def encode_weather(data)
    "#{data.summary rescue ''},#{icon_translate(data.icon) rescue ''},#{data.precipIntensity rescue ''},#{((data.precipProbability) * 100).abs rescue ''},#{change_to_celcuis(data.temperature) rescue ''},#{change_to_celcuis(data.apparentTemperatureMax) rescue ''},#{change_to_celcuis(data.apparentTemperatureMin) rescue ''},#{data.humidity rescue ''},#{data.windSpeed rescue ''},#{data.windBearing rescue ''}"
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
