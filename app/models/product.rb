class Product < ActiveRecord::Base

  belongs_to :category
  has_many :recommended_products
  has_many :product_stores
  has_many :stores, through: :product_stores
  has_many :usages
  has_many :instructions, as: :instructable

  has_attached_file :image

  delegate :name, to: :category, prefix: true

end
