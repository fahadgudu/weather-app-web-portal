class CreateCompanyProducts < ActiveRecord::Migration
  def change
    create_table :company_products do |t|
      t.integer :company_id
      t.integer :product_id

      t.timestamps null: false
    end
  end
end
