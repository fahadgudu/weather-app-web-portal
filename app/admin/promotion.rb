ActiveAdmin.register Promotion do


  filter :product

  permit_params :title, :call_to_action, :description, :product_id,
    banner_attributes: [:id, :image]

  index do
    column :title
    actions do |promotion|
      item "Notification", notification_admin_promotion_path(promotion)
    end
  end

  form do |f|
    f.inputs 'Details' do
      f.input :title
      f.input :description
      f.input :call_to_action
    end
    f.inputs :image,
      name: "Banner",
      for: [:banner, f.object.banner || Banner.new]
    f.actions
  end

  member_action :notification, method: :get do
  end

  member_action :notify, method: :post do
    resource.notify!(params)
    redirect_to resource_path, notice: "Notification Sent!"
  end

end
