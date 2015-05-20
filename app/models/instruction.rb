class Instruction < ActiveRecord::Base

  belongs_to :instructable, polymorphic:true

end
