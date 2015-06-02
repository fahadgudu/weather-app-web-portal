class Store < ActiveRecord::Base

  include HasAttachedBanner

  alias_attribute :title, :name

  has_many :product_stores, dependent: :destroy
  has_many :products, through: :product_stores

  belongs_to :company

  before_create :update_co_ordinates

  private

  def update_co_ordinates
    begin
      self.latitude, self.longitude = Geocoder.coordinates self.address
      place = Places.new(latitude, longitude)
      response = place.add!(name, address, phone)
      self.places_id = response["place_id"]
    rescue Exception => e
      Rails.logger.info e.message
      errors.add(:base, e.message)
    end

  end

end
