class AddAmountNeededToProducts < ActiveRecord::Migration
  def change
    add_column :products, :amount_needed, :float
  end
end
