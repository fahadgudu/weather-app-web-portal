class AddPositionToProblemSolvers < ActiveRecord::Migration
  def change
    add_column :problem_solvers, :position, :integer
  end
end
