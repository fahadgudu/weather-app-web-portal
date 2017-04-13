class User < ActiveRecord::Base

  geocoded_by :address
  after_validation :geocode          # auto-fetch coordinates


end
