ActiveAdmin.register GrowingGuide, as: "How To Grow" do

  menu false

  filter :title

  permit_params :title, :description,
    instructions_attributes: [:id, :detail, :_destroy],
    growing_seasons_attributes: [:id, :season, :instructions, :_destroy],
    banner_attributes: [:id, :image],
    recommended_products_attributes: [:id, :product_id, :_destroy]

  config.sort_order = 'position_asc' # assumes you are using 'position' for your acts_as_list column
  config.paginate   = false # optional; drag-and-drop across pages is not supported

  sortable

  index do
    sortable_handle_column
    column :id
    column :title
    actions
  end

  form do |f|
    f.inputs 'Details' do
      f.input :title
      f.input :description
    end
    f.inputs 'Instructions' do
      f.has_many :instructions, heading: nil, allow_destroy: true do |a|
        a.input :detail
      end
    end
    f.inputs 'When to grow' do
      f.has_many :growing_seasons, heading: nil, allow_destroy: true do |t|
        t.input :season
        t.input :instructions
      end
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
    previously_on_this_position = GrowingGuide.with_position(params[:position])
    resource.shuffle_with!(previously_on_this_position)
    redirect_to collection_path
  end

end
