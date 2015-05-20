class CreateGrowingGuides < ActiveRecord::Migration
  def change
    create_table :growing_guides do |t|
      t.string :title
      t.text :description

      t.timestamps null: false
    end
  end
end
