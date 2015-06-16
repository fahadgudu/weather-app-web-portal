json.products do
  json.set! :category_name, @category.name
  json.products do
    json.array! @products, :id, :title, :image, :product_type, :category_id
  end
end
