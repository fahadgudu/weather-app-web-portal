ActiveAdmin.register Category do

  menu label: "Categories/Sub-Categories"

  filter :parent
  filter :name

  config.sort_order = 'position_asc' # assumes you are using 'position' for your acts_as_list column
  sortable

  permit_params :name, :parent_id,
    banner_attributes: [:id, :image]

  index do
    sortable_handle_column
    id_column
    column :name
    column :parent
    column "Type", :category_type, sortable: 'parent_id'
    actions
  end

  form do |f|
    f.inputs 'Details' do
      f.input :parent
      f.input :name
    end
    f.inputs :image,
      name: "Banner",
      for: [:banner, f.object.banner || Banner.new]
    f.actions
  end

  member_action :sort, method: :post do
    previously_on_this_position = Category.with_position(params[:position])
    resource.shuffle_with!(previously_on_this_position)
    redirect_to collection_path
  end

end
