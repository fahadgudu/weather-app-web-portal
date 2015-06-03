class GrowingGuide < ActiveRecord::Base

  include HasAttachedBanner

  has_many :growing_seasons, dependent: :destroy
  has_many :instructions, as: :instructable, dependent: :destroy
  has_many :recommended_products, as: :recommendable, dependent: :destroy
  has_many :products, through: :recommended_products

  accepts_nested_attributes_for :growing_seasons, allow_destroy: true
  accepts_nested_attributes_for :instructions, allow_destroy: true
  accepts_nested_attributes_for :recommended_products, allow_destroy: true

end
