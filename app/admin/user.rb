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
    actions
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


end
