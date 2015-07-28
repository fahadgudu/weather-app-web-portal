class Category < ActiveRecord::Base

  include HasAttachedBanner
  include Repositionable

  alias_attribute :title, :name

  has_many :products, dependent: :destroy
  has_many :sub_categories, class_name: "Category", foreign_key: :parent_id, dependent: :destroy

  belongs_to :parent, class_name: "Category"

  scope :top, -> { where('parent_id IS NULL') }
  scope :sub, -> { where('parent_id IS NOT NULL') }
  scope :ordered, -> { order('position asc')}

  delegate :name, to: :parent, prefix: true

  def parent?
    !self.parent_id.present?
  end

  def category_type
    parent? ? "Category" : "Sub-category"
  end

end
