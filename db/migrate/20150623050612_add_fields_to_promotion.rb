class AddFieldsToPromotion < ActiveRecord::Migration
  def change
    add_column :promotions, :title, :string
    add_column :promotions, :call_to_action, :text
    add_attachment :promotions, :logo
  end
end
