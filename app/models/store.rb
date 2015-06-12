class Store < ActiveRecord::Base

  RADIUS = 1000

  include HasAttachedBanner

  alias_attribute :title, :name

  has_many :product_stores, dependent: :destroy
  has_many :products, through: :product_stores

  accepts_nested_attributes_for :product_stores, allow_destroy: true

  belongs_to :company

  geocoded_by :address               # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates

  reverse_geocoded_by :latitude, :longitude

  def self.search(options = {})
    radius_in_km = (options[:distance] || RADIUS).to_f / 1000
    stores = self
    stores = @stores.joins(:company).where('companies.name = ?', options[:company]) if options[:company].present?
    stores = self.near([options[:latitude],options[:longitude]], radius_in_km, units: :km) if options[:latitude].present? && options[:longitude].present?
    stores
  end

end
