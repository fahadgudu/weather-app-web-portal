class Api::V1::GrowingGuidesController < ApplicationController

  def index
    @growing_guides = GrowingGuide.all
  end

  def show
    @growing_guide = GrowingGuide.find params[:id]
  end

end
