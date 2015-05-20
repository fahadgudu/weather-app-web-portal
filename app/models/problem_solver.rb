class ProblemSolver < ActiveRecord::Base

  include HasAttachedBanner

  has_many :recommended_products, as: :recommendable
  has_many :products, through: :recommended_products

end
