class AddDeviceTokenInUser < ActiveRecord::Migration
  def change
    add_column :users, :device_token, :string, default: ''
  end
end
