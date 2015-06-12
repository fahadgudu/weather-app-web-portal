json.promotions @promotions do |promotion|
  json.extract! promotion, :id, :description, :image
  json.product do
    json.extract! promotion.product, :id, :title, :image, :description
  end
end
