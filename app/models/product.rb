class Product < ActiveRecord::Base

  include Repositionable

  enum calculator_type: [:normal, :pot, :depth]

  belongs_to :category
  has_many :recommended_products, dependent: :destroy
  has_many :company_products, dependent: :destroy
  has_many :companies, through: :company_products
  has_many :stores, through: :companies
  has_many :usages, dependent: :destroy
  has_many :instructions, as: :instructable, dependent: :destroy

  accepts_nested_attributes_for :usages, allow_destroy: true
  accepts_nested_attributes_for :instructions, allow_destroy: true
  accepts_nested_attributes_for :company_products, allow_destroy: true

  has_attached_file :image
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  delegate :name, to: :category, prefix: true
  delegate :parent_name, to: :category, prefix: true
  delegate :parent_id, to: :category, prefix: true

  scope :ordered, -> { order('position asc')}

end
