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

end
