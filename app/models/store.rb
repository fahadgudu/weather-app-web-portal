class Store < ActiveRecord::Base

  include HasAttachedBanner

  has_many :product_stores, dependent: :destroy
  has_many :products, through: :product_stores

end
