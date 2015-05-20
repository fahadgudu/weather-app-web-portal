class CreateInstructions < ActiveRecord::Migration
  def change
    create_table :instructions do |t|
      t.text :detail
      t.integer :instructable_id
      t.string :instructable_type

      t.timestamps null: false
    end
  end
end
