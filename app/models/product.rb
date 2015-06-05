class Product < ActiveRecord::Base

  belongs_to :category
  has_many :recommended_products
  has_many :product_stores
  has_many :stores, through: :product_stores
  has_many :usages
  has_many :instructions, as: :instructable

  accepts_nested_attributes_for :product_stores, allow_destroy: true
  accepts_nested_attributes_for :usages, allow_destroy: true
  accepts_nested_attributes_for :instructions, allow_destroy: true

  has_attached_file :image
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  delegate :name, to: :category, prefix: true
  delegate :parent_name, to: :category, prefix: true
  delegate :parent_id, to: :category, prefix: true

end
