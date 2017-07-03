require 'benchmark'
namespace :richgro do
  desc "This task will update the Existing Device Tokens of Parse to FCM supported Tokens"
  task charge_customer: :environment do
		start = Time.now
		puts "Rake task started at #{start}"
    WeatherUpdate.send_sms_to_users
		finish = Time.now
		diff = finish - start
		puts "Rake task ended at at #{diff}"
  end

end
