class Api::V1::DevicesController < ApplicationController

  swagger_controller :devices, "Device"

  swagger_api :create do
    summary "Register new device"
    notes "Register new device with token and postcode details"
    param :query, :access_token, :string, :required, "Access Token"
    param :query, "device[token]", :string, :required, "Device token"
    param :query, "device[postcode]", :string, :required, "postcode for the device"
    param :query, "device[device_type]", :string, :required, "Type of device OS, 'ios' or 'andriod'"
    response :unauthorized
  end

  #  {"access_token"=>"2078edc46a00588c", "device"=>{"device_type"=>"ios", "postcode"=>"2000", "token"=>"XXXXXXXXXXX"}}
  def create
    @device = Device.find_by(token: device_params[:token]) if device_params[:token].present?
    @device ||= Device.new device_params
    @device.postcode = device_params[:postcode] if device_params[:postcode].present?
    @device.save
    render json: @device
  end

  swagger_api :notify do
    summary "Send a push notification"
    notes "Send a push notification to particular device"
    param :query, :access_token, :string, :required, "Access Token"
    param :query, :id,           :string, :required, "Device ID"
    response :unauthorized
  end

  def notify
    @device = Device.find params[:id]
    n = Notifier.new @device
    n.notify("Promotion", id: @device.id)
    render json: {success: true}
    rescue Exception => e
      Rails.logger.info e.message
      render json: {success: false}
  end

  private

  def device_params
    params.require(:device).permit(:token, :postcode, :device_type)
  end

end
