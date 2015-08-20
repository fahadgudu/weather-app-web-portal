class Device < ActiveRecord::Base

  geocoded_by :postcode
  reverse_geocoded_by :latitude, :longitude
  validates_uniqueness_of :token

  after_validation :geocode

  def send_promotion(promotion)
    n = Notifier.new self
    n.notify(promotion.title, id: promotion.id)
  end

end
