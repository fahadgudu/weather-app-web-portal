class ProblemSolver < ActiveRecord::Base

  include HasAttachedBanner

  has_many :recommended_products, as: :recommendable

end
