module HasAttachedBanner
  extend ActiveSupport::Concern

  included do
    has_one :banner, as: :imageable
    accepts_nested_attributes_for :banner, allow_destroy: true
    delegate :image, to: :banner, allow_nil: true
  end

end
