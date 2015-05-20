class CreateRecommendedProducts < ActiveRecord::Migration
  def change
    create_table :recommended_products do |t|
      t.integer :product_id
      t.integer :recommenable_id
      t.string :recommendable_type

      t.timestamps null: false
    end
  end
end
