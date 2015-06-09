ActiveAdmin.register Promotion do


  filter :product

  permit_params :description, :product_id,
    banner_attributes: [:id, :image]

  form do |f|
    f.inputs 'Details' do
      f.input :product
      f.input :description
    end

    f.inputs :image,
      name: "Banner",
      for: [:banner, f.object.banner || Banner.new]
    f.actions
  end

end
