class Device < ActiveRecord::Base

  geocoded_by :postcode do |obj,results|
    if results
      results.keep_if{|r| r.formatted_address.include?'Australia'}
      first_match = results.first
      if results && first_match
        obj.latitude = first_match.geometry['location']['lat'] rescue nil
        obj.longitude = first_match.geometry['location']['lng'] rescue nil
      end
    end
  end

  reverse_geocoded_by :latitude, :longitude
  validates_uniqueness_of :token

  after_validation :geocode

	def self.send_fcm_notification(promotion, devices)
		f = Firebase.new
		data = f.data(promotion.title, id: promotion.id)
		responses = []
		(devices.each_slice(1000).to_a).each do |device_token|
			response = f.send_notification(device_token, data)
			responses << response
		end
		return responses.to_yaml
	end

  def send_promotion(promotion)
    n = Notifier.new self
    n.notify(promotion.title, id: promotion.id)
  end

end
