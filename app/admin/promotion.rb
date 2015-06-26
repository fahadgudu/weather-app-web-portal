ActiveAdmin.register Promotion do


  filter :product

  permit_params :title, :call_to_action, :description, :product_id, :call_to_action_link, :call_to_action_selection ,
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
      f.input :call_to_action_link
      f.input :call_to_action_selection, as: :select2, collection: Promotion.call_to_action_options
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
