require 'benchmark'
namespace :richgro do
  desc "This task will update the Existing Device Tokens of Parse to FCM supported Tokens"
  task change_existing_token_to_fcm: :environment do
		start = Time.now
		puts "Rake task started at #{start}"
		Firebase.change_the_existing_tokens
		finish = Time.now
		diff = finish - start
		puts "Rake task ended at at #{diff}"
  end

end
