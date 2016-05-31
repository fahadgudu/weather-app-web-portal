json.products do
  json.set! :category_name, @category.name
  json.products do
    json.array! @products do |product|
      json.extract! product, :id, :title, :image, :product_type, :category_id
      json.calculator_type (Product.calculator_types[product.calculator_type] || 0)
    end
  end
end
