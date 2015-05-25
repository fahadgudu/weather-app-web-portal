json.extract! @problem_solver, :id, :title, :problem, :resolution, :image

json.recommended_products do
  @problem_solver.products.group_by(&:category_name).each do |category_name, group|
      json.set! category_name do
        json.array! group, :id, :title, :image, :category_id
      end
  end
end
