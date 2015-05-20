class Category < ActiveRecord::Base

  include HasAttachedBanner

  has_many :products

end
