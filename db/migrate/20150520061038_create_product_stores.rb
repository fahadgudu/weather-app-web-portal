class CreateProductStores < ActiveRecord::Migration
  def change
    create_table :product_stores do |t|
      t.references :product, index: true
      t.references :store, index: true

      t.timestamps null: false
    end
    add_foreign_key :product_stores, :products
    add_foreign_key :product_stores, :stores
  end
end
