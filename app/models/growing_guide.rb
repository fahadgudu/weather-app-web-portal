class GrowingGuide < ActiveRecord::Base

  include HasAttachedBanner

  has_many :growing_seasons
  has_many :instructions, as: :instructable
  has_many :recommended_products, as: :recommendable
  has_many :products, through: :recommended_products

end
