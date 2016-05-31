class AddCalculatorTypeInProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :calculator_type, :integer, :default => 0
    
    Product.where(category: Category.where(id: [27, 28])).update_all(calculator_type: 1)
  end
  
  def self.down
    remove_column :products, :calculator
  end
end
