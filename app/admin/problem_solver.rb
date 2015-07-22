ActiveAdmin.register ProblemSolver do

  filter :problem
  filter :resolution

  config.sort_order = 'position_asc' # assumes you are using 'position' for your acts_as_list column
  config.paginate   = false # optional; drag-and-drop across pages is not supported

  sortable

  permit_params :title, :problem, :resolution,
    banner_attributes: [:id, :image],
    recommended_products_attributes: [:id, :product_id, :_destroy]

    index do
      sortable_handle_column
      id_column
      column :title
      column :problem
      column :resolution
      actions
    end

    form do |f|
      f.inputs 'Details' do
        f.input :title
        f.input :problem
        f.input :resolution
      end
      f.inputs 'Recommended products' do
        f.has_many :recommended_products, heading: nil, allow_destroy: true do |t|
          t.input :product_id,   as: :select,      :collection => Product.all
        end
      end
      f.inputs :image,
        name: "Banner",
        for: [:banner, f.object.banner || Banner.new]
      f.actions
    end

end
