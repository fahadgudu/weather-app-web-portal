class Api::V1::WeathersController < ApplicationController

    def index
      @users = User.all
    end

    def show
      @user = User.find_by device_token params[:id]
      lat, long = @user.latitude, @user.longitude
      @weather_data = @user.get_weather_data(lat, long)
      render :json => @weather_data
    end

    def weather_forecast
      @user = User.find_by_device_token(params[:user][:device_token]) if params[:user][:device_token].present?
      if @user.present?
        lat, long = @user.latitude, @user.longitude
        @weather_data = @user.get_weather_data(lat, long)
        render :json => @weather_data
      else
        render :json => { :errors => 'No internet connectivity' }, :status => 422
      end
    end

    def register
      if !User.find_by_device_token(params[:user][:device_token])
        @user = User.find_by(mobile_number: user_params[:mobile_number]) if user_params[:mobile_number].present?
        @user.update_attributes(user_params) if !@user.nil? && @user.present?
        @user ||= User.new user_params
        @user.save
        render json: @user
      else
        render :json => { :errors => 'آپ کا نمبر پہلے ہی محفوظ ہے' }, :status => 422
      end
    end

    def weather_update
      @user = User.find_by(device_token: weather_params[:device_token]) if params[:user][:device_token].present?
      if !@user.nil? && @user.present?
        @user.update_attributes(user_params)
        if !@user.weather_update.present?
          @user.weather_update = WeatherUpdate.create({after_four_hours: weather_params[:after_four_hours], daily: weather_params[:daily], weekly: weather_params[:weekly]})
        else
          @user.weather_update.update_attributes(after_four_hours: weather_params[:after_four_hours], daily: weather_params[:daily], weekly: weather_params[:weekly])
        end
      else
        @user.weather_update = WeatherUpdate.create({after_four_hours: user_params[:after_four_hours], daily: user_params[:daily], weekly: user_params[:weekly]})
        @user.save
      end
      render json: @user
    end

    def do_it
      @user = User.create!(user_params)
      @user.weather_update = WeatherUpdate.create({after_four_hours: user_params[:after_four_hours], daily: user_params[:daily], weekly: user_params[:weekly]})
    end

    def user_params
      params.require(:user).permit(:mobile_number, :latitude, :longitude, :device_token)
    end

    def weather_params
      params.require(:user).permit(:user_id, :after_four_hours, :daily, :weekly, :device_token)
    end




end
