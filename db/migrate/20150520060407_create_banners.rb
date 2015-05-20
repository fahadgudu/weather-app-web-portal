class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.string :imageable_type
      t.integer :imageable_id

      t.timestamps null: false
    end
  end
end
