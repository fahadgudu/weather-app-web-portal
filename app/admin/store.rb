ActiveAdmin.register Store, as: "Retailer" do

  permit_params :name, :address, :postcode, :phone, :company_id

  filter :company
  filter :name
  filter :address
  filter :postcode
  filter :phone

  index do
    column :name
    column :address
    column :postcode
    column :phone
    column :company
  end

  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :address
      f.input :postcode
      f.input :phone
      f.input :company
    end
    f.actions

  end

end
