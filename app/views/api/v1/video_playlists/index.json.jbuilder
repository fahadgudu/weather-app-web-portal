json.video_playlists do
  json.array! @playlists, :id, :title, :cover_image, :youtube_playlist_id
end