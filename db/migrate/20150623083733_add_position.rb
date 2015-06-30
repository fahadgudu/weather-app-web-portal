class AddPosition < ActiveRecord::Migration
  def change
    add_column :growing_guides, :position, :integer
    add_column :products, :position, :integer
    add_column :categories, :position, :integer
  end
end
