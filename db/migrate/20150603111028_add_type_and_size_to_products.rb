class AddTypeAndSizeToProducts < ActiveRecord::Migration
  def change
    add_column :products, :product_type, :integer
    add_column :products, :product_size, :integer
  end
end
