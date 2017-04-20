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


end
