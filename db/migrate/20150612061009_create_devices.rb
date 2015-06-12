class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :token
      t.string :postcode
      t.string :device_type

      t.timestamps null: false
    end
  end
end
