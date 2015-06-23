ActiveAdmin.register Company do

  permit_params :name,
    banner_attributes: [:id, :image],
    company_products_attributes: [:id, :company_id, :product_id]

  form do |f|
    f.inputs "Details" do
      f.input :name
    end
    f.inputs 'Products' do
      f.has_many :company_products, heading: nil, allow_destroy: true do |t|
        t.input :product_id, as: :select, collection: Product.all
      end
    end
    f.inputs :image,
      name: "Logo",
        for: [:banner, f.object.banner || Banner.new]
    f.actions
  end

end
