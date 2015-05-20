class Api::V1::GrowingGuidesController < ApplicationController

  def index
    @growing_guides = GrowingGuide.all
    respond_to do |format|
      format.json
    end
  end

end
