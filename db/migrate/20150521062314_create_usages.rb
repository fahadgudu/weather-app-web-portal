class CreateUsages < ActiveRecord::Migration
  def change
    create_table :usages do |t|
      t.string :title
      t.text :description
      t.references :product, index: true

      t.timestamps null: false
    end
    add_foreign_key :usages, :products
  end
end
