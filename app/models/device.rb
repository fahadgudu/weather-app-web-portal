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

  def send_promotion(promotion)
    n = Notifier.new self
    n.notify(promotion.title, id: promotion.id)
  end

end
