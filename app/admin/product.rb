ActiveAdmin.register Product do

  permit_params :title, :description, :category_id, :image, :amount_needed, :product_type, :product_size,
    usages_attributes: [:id, :title, :description, :_destroy],
    instructions_attributes: [:id, :detail, :_destroy],
    company_products_attributes: [:id, :company_id, :_destroy]

  filter :category
  filter :title
  filter :stores
  filter :description

  index do
    column :id
    column :title
    column :amount_needed
    column :product_size
    column :product_type
    column :category
    actions
  end

  form do |f|
    f.inputs "Details" do
      f.input :title
      f.input :description
      f.input :category, as: :select, collection: Category.sub
      f.input :image, as: :file
      f.input :amount_needed
      f.input :product_type, as: :select, collection: [["Bag",0],["Bucket",1],["Bottle",2],["Hold on",3],["Potting", 4]]
      f.input :product_size
    end
    f.inputs 'How to use' do
      f.has_many :usages, heading: nil, allow_destroy: true do |t|
        t.input :title
        t.input :description
      end
    end
    f.inputs 'Instructions' do
      f.has_many :instructions, heading: nil, allow_destroy: true do |t|
        t.input :detail
      end
    end
    f.inputs 'Retailers' do
      f.has_many :company_products, heading: nil, allow_destroy: true do |t|
        t.input :company_id, as: :select, collection: Company.all
      end
    end
    f.actions
  end

end
