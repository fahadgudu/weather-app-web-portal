module Repositionable
  extend ActiveSupport::Concern

  included do
    acts_as_list
    scope :with_position, ->(pos) { find_by(position: pos) }
  end

  def shuffle_with!(previous)
    self.set_list_position previous.position
  end

end
