class GrowingGuide < ActiveRecord::Base

  include HasAttachedBanner
  include ActsAsRecommendable

  has_many :growing_seasons, dependent: :destroy
  has_many :instructions, as: :instructable, dependent: :destroy

  accepts_nested_attributes_for :growing_seasons, allow_destroy: true
  accepts_nested_attributes_for :instructions, allow_destroy: true

  acts_as_list

end
