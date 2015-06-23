json.extract! @product, :id, :title, :description, :image, :amount_needed, :category_id, :category_name, :category_parent_name, :category_parent_id, :product_type
json.stores @stores do |store|
  json.extract! store, :id, :name, :address, :postcode, :latitude, :longitude, :phone
  json.company do
    if store.company.present?
      json.extract! store.company, :id, :name, :image
    end
  end
end
json.how_to_use @product.usages, :title, :description
json.instructions @product.instructions, :detail
json.company_list @companies, :id, :name
