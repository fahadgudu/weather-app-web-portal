class Promotion < ActiveRecord::Base

  include HasAttachedBanner

  belongs_to :product

end
