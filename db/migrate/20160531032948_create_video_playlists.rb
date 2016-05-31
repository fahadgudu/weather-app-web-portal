class CreateVideoPlaylists < ActiveRecord::Migration
  def change
    create_table :video_playlists do |t|
      t.string :title
      t.attachment :cover_image
      t.string :youtube_playlist_id
      t.timestamps null: false
    end
  end
end
