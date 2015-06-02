class AddPlacesIdToRetailer < ActiveRecord::Migration
  def change
    add_column :stores, :places_id, :string
  end
end
