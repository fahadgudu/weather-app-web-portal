ActiveAdmin.register Company do

  permit_params :name, product_ids: [],
    banner_attributes: [:id, :image], company_products_attributes: [:id, :company_id, :product_id]

  form do |f|
    f.inputs "Details" do
      f.input :name
    end
    f.inputs 'Products' do
      f.input :product_ids, as: :select2_multiple, collection: Product.all, label: 'Select Products'
    end

    f.inputs 'Logo', for: [:banner, f.object.banner || Banner.new] do |b|
      b.input :image, :hint => f.object.banner.nil? ? image_tag('#', class: 'hide') : image_tag(asset_path(f.object.banner.image.path))
    end
    f.actions
  end

end
