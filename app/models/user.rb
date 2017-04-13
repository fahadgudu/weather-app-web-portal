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
      @client.account.messages.create({:from => number, :to => user, :body => "welcome dude!!"})
    rescue StandardError => ex
      Rails.logger.error "#{ex.message}"
    end
  end

  def get_weather_data(lat = nil, long = nil)
      ForecastIO.api_key = '19b2f7931e74fa8fbfd9c0c8e9f79937'
      forecast = ForecastIO.forecast(latitude: lat, longitude: long)
      forecast.to_json

  end

  end
