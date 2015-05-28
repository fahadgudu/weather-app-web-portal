class Store < ActiveRecord::Base

  include HasAttachedBanner

  alias_attribute :title, :name

  has_many :product_stores, dependent: :destroy
  has_many :products, through: :product_stores

  belongs_to :company

end
