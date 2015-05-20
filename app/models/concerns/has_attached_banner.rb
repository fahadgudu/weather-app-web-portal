module HasAttachedBanner
  extend ActiveSupport::Concern

  included do
    has_one :banner, as: :imageable
    delegate :image, to: :banner
  end

end
