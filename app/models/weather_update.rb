class WeatherUpdate < ActiveRecord::Base
  belongs_to :user

  def self.send_sms_to_users

    users = User.all



  end

end

