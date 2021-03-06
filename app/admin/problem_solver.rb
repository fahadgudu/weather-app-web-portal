ActiveAdmin.register ProblemSolver do

  menu false
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

      f.inputs 'Banner', for: [:banner, f.object.banner || Banner.new] do |b|
        b.input :image, :hint => f.object.banner.nil? ? image_tag('#', class: 'hide') : image_tag(asset_path(f.object.banner.image.path))
      end
      f.actions
    end

    member_action :sort, method: :post do
      previously_on_this_position = ProblemSolver.with_position(params[:position])
      resource.shuffle_with!(previously_on_this_position)
      redirect_to collection_path
    end

end
