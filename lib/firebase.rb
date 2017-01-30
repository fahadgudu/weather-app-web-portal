require 'fcm'
class Firebase
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



end