class Api::V1::WeathersController < ApplicationController

    def index
      @users = User.all
    end

    def show
      @user = User.find params[:id]
      lat, long = @user.latitude, @user.longitude
      @weather_data = @user.get_weather_data(lat, long)
      render :json => @weather_data
    end

    def register
      @user = User.find_by(mobile_number: user_params[:mobile_number]) if user_params[:mobile_number].present?
      @user.update_attributes(user_params) if !@user.nil? && @user.present?
      @user ||= User.new user_params
      @user.save
      render json: @user
    end

    def weather_update
      @weather = WeatherUpdate.find_by(user_id: weather_params[:user_id]) if weather_params[:user_id].present?
      if !@weather.nil? && @weather.present?
        @weather.update_attributes(weather_params)
      else
        @weather ||= WeatherUpdate.new(weather_params)
        @weather.save
      end
      render json: @weather
    end



    def user_params
      params.require(:user).permit(:mobile_number, :latitude, :longitude)
    end

    def weather_params
      params.require(:user).permit(:user_id, :after_four_hours, :daily, :weekly)
    end




end
