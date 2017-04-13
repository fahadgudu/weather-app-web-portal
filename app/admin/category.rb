ActiveAdmin.register Category do

  menu false

  filter :parent
  filter :name

  config.sort_order = 'position_asc' # assumes you are using 'position' for your acts_as_list column
  sortable

  permit_params :name, :parent_id, banner_attributes: [:id, :image]

  index do
    sortable_handle_column
    id_column
    column :name
    column :parent
    column "Type", :category_type, sortable: 'parent_id'
    actions
  end

  form html: {enctype: 'multipart/form-data'} do |f|
    f.inputs 'Details' do
      f.input :parent
      f.input :name
    end
    f.inputs 'Banner', for: [:banner, f.object.banner || Banner.new] do |b|
      b.input :image, :hint => f.object.banner.nil? ? image_tag('#', class: 'hide') : image_tag(asset_path(f.object.banner.image.path))
    end

    f.actions
  end

  member_action :sort, method: :post do
    previously_on_this_position = Category.with_position(params[:position])
    resource.shuffle_with!(previously_on_this_position)
    redirect_to collection_path
  end

end
