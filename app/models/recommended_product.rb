class RecommendedProduct < ActiveRecord::Base

  belongs_to :recommendable, polymorphic:true
  belongs_to :product

end
