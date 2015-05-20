class Product < ActiveRecord::Base

  belongs_to :category
  has_many :recommended_products
  has_many :product_stores
  has_many :stores, through: :product_stores

end
