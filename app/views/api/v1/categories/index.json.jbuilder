json.array! @categories do |category|
    json.extract! category, :id, :name, :title, :image
    if params[:tree].present?
      json.sub_categories do
        json.array! category.sub_categories do |sub_category|
          json.extract! sub_category, :id, :name, :title, :image
          json.products do
            json.array! sub_category.products, :id, :title, :image, :product_type, :category_id
          end
        end
      end
    end
end
