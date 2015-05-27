json.results @results do |result|
  if result.is_a? Product
    json.extract! result, :id, :title, :image, :category_id, :category_name
  else
    json.extract! result, :id, :title, :image
  end
end
