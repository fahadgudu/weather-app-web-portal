class CreateWeatherUpdates < ActiveRecord::Migration
  def change
    create_table :weather_updates do |t|

      t.belongs_to :user, index: true
      t.boolean :after_four_hours
      t.boolean :daily
      t.boolean :weekly

      t.timestamps null: false
    end
  end
end
