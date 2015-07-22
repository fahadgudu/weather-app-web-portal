class ProblemSolver < ActiveRecord::Base

  include HasAttachedBanner
  include ActsAsRecommendable

  acts_as_list

end
