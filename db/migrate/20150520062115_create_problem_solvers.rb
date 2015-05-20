class CreateProblemSolvers < ActiveRecord::Migration
  def change
    create_table :problem_solvers do |t|
      t.string :title
      t.text :problem
      t.text :resolution

      t.timestamps null: false
    end
  end
end
