ActiveAdmin.register WeatherUpdate do

  permit_params :id, :user_id, :after_four_hours, :daily, :weekly

  index do
    selectable_column
    id_column
    column :user do |u|
      u.user.full_name rescue ''
    end
    column :after_four_hours, label: 'Update User After 4 hours'
    column :daily, label: 'Daily Update'
    column :weekly, label: 'Weekly Update'
    actions
  end

  show do |u|
    attributes_table do
      row :id
      row :user do |u|
        u.user.full_name rescue ''
      end
      row :after_four_hours, label: 'Update User After 4 hours'
      row :daily, label: 'Daily Update'
      row :weekly, label: 'Weekly Update'
    end
  end


  form do |f|
    f.inputs "User Weather Update" do
      f.input  :user_id, as: :select, collection: User.all.order('first_name ASC').map{ |s| [s.full_name, s.id] }.uniq
      f.input :after_four_hours
      f.input :daily
      f.input :weekly
    end
    f.actions
  end


end
