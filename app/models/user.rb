class User < ActiveRecord::Base

  has_one :weather_update
  geocoded_by :address
  after_validation :geocode          # auto-fetch coordinates

  def send_sms
    begin
      account_sid = Rails.application.secrets.twilio['account_sid']
      auth_token = Rails.application.secrets.twilio['auth_token']
      number = Rails.application.secrets.twilio['number']
      @client = Twilio::REST::Client.new account_sid, auth_token
      # user = self.mobile_number
      user = self
      lat, long = user.latitude, user.longitude
      @weather_data = user.get_weather_data(lat, long)
      @client.account.messages.create({:from => '+14807122626', :to => user.mobile_number, :body => @weather_data})
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
    first_name
  end

  def name
    first_name
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
    #w_hash[:s] =  data.summary rescue ''
    #    w_hash[:i] =  icon_translate(data.icon) rescue ''
    #    w_hash[:c] =  data.precipIntensity rescue ''
    #    w_hash[:p] =  ((data.precipProbability) * 100).to_i rescue ''
    #    w_hash[:t] =  change_to_celcuis(data.temperature) rescue ''
    #    w_hash[:x] =  change_to_celcuis(data.apparentTemperatureMax) rescue ''
    #    w_hash[:m] =  change_to_celcuis(data.apparentTemperatureMin) rescue ''
    #    w_hash[:h] =  data.humidity rescue ''
    #    w_hash[:w] =  data.windSpeed rescue ''
    #    w_hash[:b] =  data.windBearing rescue ''
    "#{icon_translate(data.icon) rescue ''}:#{icon_translate(data.icon) rescue ''}:#{data.precipIntensity rescue ''}:#{((data.precipProbability) * 100).abs rescue ''}:#{change_to_celcuis(data.temperature) rescue '0'}:#{change_to_celcuis(data.apparentTemperatureMax.nil? ? data.temperature : data.apparentTemperatureMax) rescue '0'}:#{change_to_celcuis(data.apparentTemperatureMin.nil? ? data.temperature - 10: data.apparentTemperatureMin) rescue '0'}:#{data.humidity rescue ''}:#{data.windSpeed rescue ''}:#{data.windBearing rescue ''}"
  end

  # [
  #
  #     "1:1:0.0235:6.0:10:0:0:0.44:5.55:172",
  #     "2:2:0.0083:38.0:0:38:29:0.5:3.9:104",
  #     "3:3:0.0021:16.0:0:39:27:0.48:4.03:111",
  #     "4:4:0.0067:22.0:0:12:27:0.5:3.67:130",
  #     "5:5:0.0003:1.0:0:50:29:0.48:3.49:108",
  #     "6:6:0.0043:9.0:0:43:31:0.43:2.11:140",
  #     "7:7:0.0186:41.0:0:20:28:0.63:6.83:124",
  #     "8:8:0.0291:38.0:0:25:27:0.76:8.01:113",
  #     "9:9:0.0791:63.0:0:0:24:0.82:8.3:109"
  #
  # ]

  def change_to_celcuis(temperature)
    ((temperature - 32) * 5.0 / 9.0).ceil
  end

  def icon_translate(icon)
    icons = ['clear-day', 'clear-night', 'rain', 'snow', 'sleet', 'wind', 'fog', 'cloudy', 'partly-cloudy-day','partly-cloudy-night','hail', 'thunderstorm','tornado']
    idx = icons.index{|s| s.include?(icon)}
    idx
  end

end
