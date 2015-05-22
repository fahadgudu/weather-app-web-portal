class Api::V1::GrowingGuidesController < ApplicationController

  swagger_controller :growing_guides, "How to grow"

  swagger_api :index do
    summary "Fetches all 'How to grow' guides"
    notes "This lists all the 'How to grow' guides"
    param :query, :access_token, :string, :required, "Access Token"
    response :unauthorized
  end

  def index
    @growing_guides = GrowingGuide.all
  end

  swagger_api :show do
    summary "Fetch details for 'How to grow' guide"
    notes "This display details for a guide"
    param :query, :access_token, :string,  :required, "Access Token"
    param :query, :id,           :integer, :required, "ID"
    response :unauthorized
  end

  def show
    @growing_guide = GrowingGuide.find params[:id]
  end

end
