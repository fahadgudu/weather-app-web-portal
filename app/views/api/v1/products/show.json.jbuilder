json.extract! @product, :id, :title, :description, :image, :amount_needed, :category_id, :category_name, :category_parent_name, :category_parent_id
json.stores @stores, :id, :name, :address, :postcode, :latitude, :longitude, :phone, :image, :company
json.how_to_use @product.usages, :title, :description
json.instructions @product.instructions, :detail
