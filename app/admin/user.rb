ActiveAdmin.register User do

  permit_params :first_name, :last_name, :mobile_number, :address, :latitude, :longitude

  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :mobile_number
    column :address
    column :latitude
    column :longitude
    actions defaults: true do |user|
      span link_to 'Send SMS', send_sms_admin_user_path(user)
      span link_to 'Forecast', weather_forecast_admin_user_path(user), class: 'fancybox member_link', data: { 'fancybox-type' => 'ajax' } if user.address.present?
    end
  end

  show  do |user|
    attributes_table do
      row :first_name
      row :last_name
      row :mobile_number
      row :address
      row :latitude
      row :longitude
    end
  end

  filter :first_name
  filter :last_name
  filter :mobile_number
  filter :address

  form do |f|
    f.inputs "User Details" do
      f.input :first_name
      f.input :last_name
      f.input :mobile_number
      f.input :address
    end
    f.actions
  end

  member_action :send_sms, method: [:post, :get] do
    resource.send_sms
    redirect_to admin_users_path, notice: 'SMS is sent'
  end

  member_action :weather_forecast, method: [:post, :get] do
    user = resource
    lat, long = resource.latitude, resource.longitude
    @weather_data = user.get_weather_data(lat, long)
    render :json => @weather_data
  end


end
