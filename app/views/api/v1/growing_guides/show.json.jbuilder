json.extract! @growing_guide, :id, :title, :description, :image
json.instructions @growing_guide.instructions, :detail
json.when_to_grow @growing_guide.growing_seasons, :season, :instructions

json.recommended_products do
  @growing_guide.products.group_by(&:category_name).each do |category_name, group|
      json.set! category_name do
        json.array! group, :title, :image
      end
  end
end
