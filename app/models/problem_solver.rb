class ProblemSolver < ActiveRecord::Base

  include HasAttachedBanner
  include ActsAsRecommendable
  include Repositionable

  scope :position_asc, -> { order('position asc') }

end
