class CreatePromotions < ActiveRecord::Migration
  def change
    create_table :promotions do |t|
      t.text :description
      t.integer :product_id

      t.timestamps null: false
    end
  end
end
