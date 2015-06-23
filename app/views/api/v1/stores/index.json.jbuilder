json.retailers @stores do |store|
  json.extract! store, :id, :name, :address, :postcode, :latitude, :longitude, :phone
  json.company do
    if store.company.present?
      json.extract! store.company, :id, :name, :image
    end
  end
end
json.company_list @companies, :id, :name
