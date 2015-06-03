ActiveAdmin.register GrowingGuide, as: "How To Grow" do

  menu label: "How To Grow"

  filter :title

  permit_params :title, :description,
    instructions_attributes: [:id, :detail, :_destroy],
    growing_seasons_attributes: [:id, :season, :instructions, :_destroy],
    banner_attributes: [:id, :image],
    recommended_products_attributes: [:id, :product_id, :_destroy]

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
    f.inputs :image,
      name: "Banner",
      for: [:banner, f.object.banner || Banner.new]
    f.actions
  end


end
