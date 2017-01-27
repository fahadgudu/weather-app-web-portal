class Api::V1::VideoPlaylistsController < ApplicationController

  swagger_controller :video_playlists, "Video playlists"

  swagger_api :index do
    summary "Returns all video playlists"
    notes "This lists all video playlists"
    param :query, :access_token, :string, :required, "Access Token"
    response :unauthorized
  end

  def index
    @playlists = VideoPlaylist.all
  end
end
