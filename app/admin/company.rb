ActiveAdmin.register Company do

  permit_params :name, product_ids: [],
    banner_attributes: [:id, :image],
    company_products_attributes: [:id, :company_id, :product_id]

  form do |f|
    f.inputs "Details" do
      f.input :name
    end
    f.inputs 'Products' do
      f.input :product_ids, as: :select2_multiple, collection: Product.all
    end
    f.inputs :image,
      name: "Logo",
        for: [:banner, f.object.banner || Banner.new]
    f.actions
  end

end
