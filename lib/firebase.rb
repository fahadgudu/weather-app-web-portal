require 'fcm'
class Firebase
	include HTTParty
	API_KEY = 'AAAAsNdC6Tg:APA91bFHqnaqrK4Ul63E029hS7zkQ3Fy1I4BvUvDl9OPJIB6packv1A_CwZgexQC34fEONY5kkqunjrfhlfpnNYmMmdNBbCBuf2duQKl3dMm3YuG2KJOi8hCJ30muT8dr-_rwof5g7_9'

	def initialize
		@fcm = FCM.new(Firebase::API_KEY)
	end

	def data(message, options)
		options = { notification:
									 { body: message, }.merge!(options),
							 data: { alert: message }.merge!(options),
							 priority: 'high',
							 collapse_key: "promotions"
		}

	end

	def send_notification(tokens, data)
		# @fcm = FCM.new(API_KEY)
		@fcm.send(tokens, data)
	end

	def self.change_the_existing_tokens
		url_to_import =  'https://iid.googleapis.com/iid/v1:batchImport'
		(Device.all.pluck(:token).each_slice(100).to_a).each_with_index do |tokens, index|
			puts "FCM Server API call => #{index} to modify the RichGro Push Notifications"
			@result = HTTParty.post(url_to_import.to_str,
									body:
											{ application: 'au.com.Richgro',
												sandbox: false,
												apns_tokens: tokens
									}.to_json,
									:headers => { 'Authorization' => "key=#{Firebase::API_KEY}",
																'Content-Type' => 'application/json'} )
				puts @result['results']
				if @result['results'].present?
					@result['results'].each do |t|
						begin
							device = Device.find_by(token: t['apns_token'])
							puts "#{device.id} with #{device.try(:token)} is updated to new #{t['registration_token']} " if t['status']=='OK'
							device.update_attributes!(token: t['registration_token']) if t['status']=='OK'
							puts 'Updated Device'
						rescue
							puts "#{device.id} is not UPDATED!!"
							next
						end
					end
				end
			end
		end





end