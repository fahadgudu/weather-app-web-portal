json.extract! @user, :id, :first_name, :last_name, :mobile_number, :address, :latitude, :longitude, :created_at, :updated_at
json.weather_update do
  @weather = WeatherUpdate.find_by user_id: @user.id
  if @weather.present?
    json.extract! @weather, :after_four_hours, :daily, :weekly, :created_at, :updated_at
  end
end