ActiveAdmin.register Store, as: "Retailer" do

  menu false
  permit_params :name, :address, :postcode, :phone, :company_id, :email, :state

  filter :company
  filter :name
  filter :address
  filter :postcode
  filter :phone
  filter :state
  filter :email

  active_admin_importable do |model, hash|
    model.find_or_initialize_by(name: hash[:retailer]) do |store|
      company = Company.find_by_name(hash[:company])
      if company
        store.company_id = company.id
        store.phone = hash[:phone]
        store.address = hash[:address]
        store.email = hash[:email]
        store.state = hash[:state]
        store.save
      end
    end
  end

  index do
    column :name
    column :address
    column :email
    column :phone
    column :company
    column :state
    actions
  end

  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :address
      f.input :phone
      f.input :company
      f.input :email
      f.input :state
    end
    f.actions

  end

end
