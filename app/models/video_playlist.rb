class VideoPlaylist < ActiveRecord::Base

  has_attached_file :cover_image
  validates_attachment_content_type :cover_image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

end
