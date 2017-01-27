ActiveAdmin.register VideoPlaylist do


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end

  permit_params :title, :cover_image, :youtube_playlist_id
  
  index do
    id_column
    column :title
    column do |playlist|
      image_tag asset_path(playlist.cover_image.path), class: 'cover_image_thumb'
    end
    column :youtube_playlist_id do |playlist|
      link_to playlist.youtube_playlist_id, "https://www.youtube.com/playlist?list=#{playlist.youtube_playlist_id}"
    end
    actions
  end
  
  form do |f|
    inputs do
      input :title
      input :cover_image, as: :file, hint: f.object.cover_image.nil? ? image_tag('#', class: 'hide') : image_tag(asset_path(f.object.cover_image.path))
      input :youtube_playlist_id
    end
    actions
  end
end
