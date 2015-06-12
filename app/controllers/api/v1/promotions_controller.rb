class Api::V1::PromotionsController < ApplicationController

  swagger_controller :promotions, "Promotions"

  swagger_api :index do
    summary "Fetches all promotions"
    notes "This lists all the promotions"
    param :query, :access_token, :string, :required, "Access Token"
    response :unauthorized
  end

  def index
    @promotions = Promotion.all
  end

  swagger_api :show do
    summary "Get detail of specific promotion"
    notes "Get detail of promotion specified by ID"
    param :query, :access_token, :string, :required, "Access Token"
    param :query, :id,           :integer, :required, "ID"
    response :unauthorized
  end

  def show
    @promotion = Promotion.find params[:id]
  end

end
