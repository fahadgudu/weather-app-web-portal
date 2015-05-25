class Api::V1::StoresController < ApplicationController

  swagger_controller :stores, "Retailer"

  swagger_api :index do
    summary "Returns the list of retailers"
    notes "Lists all retailers"
    param :query, :access_token, :string, :required, "Access Token"
    response :unauthorized
  end

  def index
    @stores = Store.all
  end

  swagger_api :show do
    summary "Returns the deails of a particular retailer"
    notes "This display details of a particular retailer"
    param :query, :access_token, :string, :required, "Access Token"
    param :query, :id,           :integer, :required, "ID of the retailer"
    response :unauthorized
  end

  def show
    @store = Store.find params[:id]
  end

end
