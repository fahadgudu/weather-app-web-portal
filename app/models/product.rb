class Product < ActiveRecord::Base

  belongs_to :category
  has_many :recommended_products
  has_many :product_stores
  has_many :stores, through: :product_stores
  has_many :usages
  has_many :instructions, as: :instructable

  has_attached_file :image
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  delegate :name, to: :category, prefix: true

end
