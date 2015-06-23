class Store < ActiveRecord::Base

  RADIUS = 1000

  alias_attribute :title, :name

  belongs_to :company
  has_many :products, through: :company

  geocoded_by :address
  after_validation :geocode          # auto-fetch coordinates

  delegate :image, to: :company, allow_nil: true

  reverse_geocoded_by :latitude, :longitude

  def self.search(options = {})
    radius_in_km = (options[:distance] || RADIUS).to_f / 1000
    stores = self
    stores = stores.joins(:company).where('companies.name = ?', options[:company]) if options[:company].present?
    stores = self.near([options[:latitude],options[:longitude]], radius_in_km, units: :km) if options[:latitude].present? && options[:longitude].present?
    stores.all
  end

end
