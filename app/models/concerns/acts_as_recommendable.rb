module ActsAsRecommendable
  extend ActiveSupport::Concern

  included do
    has_many :recommended_products, as: :recommendable, dependent: :destroy
    has_many :products, through: :recommended_products
    accepts_nested_attributes_for :recommended_products, allow_destroy: true
  end

end
