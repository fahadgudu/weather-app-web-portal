class Promotion < ActiveRecord::Base

  include HasAttachedBanner

  belongs_to :product

  def notify!(options)
    devices = Device.within_bounding_box([options[:sw_lat],options[:sw_lng],options[:ne_lat],options[:ne_lng]])
    devices.each do |device|
      device.send_promotion(self)
    end
  end

end
