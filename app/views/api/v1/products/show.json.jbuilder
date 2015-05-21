json.extract! @product, :id, :title, :description, :image
json.stores @product.stores
json.how_to_use @product.usages, :title, :description
json.instructions @product.instructions, :detail
