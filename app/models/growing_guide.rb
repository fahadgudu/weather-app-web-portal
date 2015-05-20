class GrowingGuide < ActiveRecord::Base

  include HasAttachedBanner

  has_many :growing_seasons
  has_many :instructions, as: :instructable
  has_many :recommended_products, as: :recommendable

end
