json.extract! @product, :id, :title, :description, :image, :amount_needed, :category_id, :category_name
json.stores @product.stores, :id, :name, :address, :postcode, :latitude, :longitude, :phone, :image
json.how_to_use @product.usages, :title, :description
json.instructions @product.instructions, :detail
