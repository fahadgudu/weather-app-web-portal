class ChangeDefaultsForProductsAmounts < ActiveRecord::Migration
  def change
    change_column :products, :amount_needed, :float, default: 0
  end
end
