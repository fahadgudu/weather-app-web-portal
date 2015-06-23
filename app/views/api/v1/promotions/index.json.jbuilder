json.promotions @promotions do |promotion|
  json.extract! promotion, :id, :title, :description, :image, :call_to_action
end
