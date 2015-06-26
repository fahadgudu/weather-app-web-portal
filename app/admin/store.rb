ActiveAdmin.register Store, as: "Retailer" do

  permit_params :name, :address, :postcode, :phone, :company_id

  filter :company
  filter :name
  filter :address
  filter :postcode
  filter :phone

  active_admin_importable do |model, hash|
    model.find_or_initialize_by(name: hash[:name]) do |store|
      company = Company.find_by_name(hash[:company])
      if company
        store.company_id = company.id
        store.phone = hash[:phone]
        store.address = hash[:address]
        store.postcode = hash[:number]
        store.fax = hash[:fax]
        store.email = hash[:email]
        store.state = hash[:state]
        store.save
      end
    end
  end

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
