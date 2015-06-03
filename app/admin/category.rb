ActiveAdmin.register Category do

  menu label: "Categories/Sub-Categories"

  filter :parent
  filter :name

  permit_params :name, :parent_id,
    banner_attributes: [:id, :image]

  index do
    id_column
    column :name
    column :parent
    column "Type", :category_type
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

end
