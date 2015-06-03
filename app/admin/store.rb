ActiveAdmin.register Store, as: "Retailer" do

  permit_params :name, :address, :postcode, :phone, :company_id,
    banner_attributes: [:id, :image]

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
    f.inputs :image,
      name: "Logo",
        for: [:banner, f.object.banner || Banner.new]
      f.actions
  end

end
