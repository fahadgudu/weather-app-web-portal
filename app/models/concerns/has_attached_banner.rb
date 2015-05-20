module HasAttachedBanner
  extend ActiveSupport::Concern

  included do
    has_one :banner, as: :imageable
  end

end
