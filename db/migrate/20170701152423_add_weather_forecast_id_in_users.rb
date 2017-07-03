class AddWeatherForecastIdInUsers < ActiveRecord::Migration
  def change
    add_column :users, :weather_update_id, :integer

  end
end
