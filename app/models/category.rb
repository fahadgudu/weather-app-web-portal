class Category < ActiveRecord::Base

  include HasAttachedBanner

  has_many :products
  has_many :sub_categories, class_name: "Category", foreign_key: :parent_id

  scope :top, -> { where('parent_id IS NULL') }
  scope :sub, -> { where('parent_id IS NOT NULL') }

end
