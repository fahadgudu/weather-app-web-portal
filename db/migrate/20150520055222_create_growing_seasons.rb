class CreateGrowingSeasons < ActiveRecord::Migration
  def change
    create_table :growing_seasons do |t|
      t.string :season
      t.text :instructions
      t.references :growing_guide, index: true

      t.timestamps null: false
    end
    add_foreign_key :growing_seasons, :growing_guides
  end
end
