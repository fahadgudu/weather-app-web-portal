json.promotion do
  json.extract! @promotion, :id, :description, :image
  json.product do
    json.extract! @promotion.product, :id, :title, :image, :description, :category_id, :category_name
  end
end
