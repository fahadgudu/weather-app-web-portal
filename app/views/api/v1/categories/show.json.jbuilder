json.category do
  json.set! :name, @category.name
  json.sub_categories do
    json.array! @sub_categories, :id, :name, :image, :title
  end
end
