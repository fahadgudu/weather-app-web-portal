class AddGeoCoOrdinatesToDevices < ActiveRecord::Migration
  def change
    add_column :devices, :latitude, :float
    add_column :devices, :longitude, :float
  end
end
