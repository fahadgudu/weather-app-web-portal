class Api::V1::SearchController < ApplicationController

  swagger_controller :search, "Search"

  swagger_api :index do
    summary "Returns the search results"
    notes "Return search results against a section. Where section is either of the 'how_to_grow', 'product', 'problem_solver' , or 'retailer'"
    param :query, :section,  :string, :required, "either of 'how_to_grow', 'product', 'problem_solver', or 'retailer'"
    param :query, :search,   :string, :required, "Term to search against"
    response :unauthorized
  end

  def index
    column = 'title'
    case params[:section]
    when "how_to_grow"
      klass = GrowingGuide
    when "product"
      klass = Product
    when "retailer"
      klass = Store
      column = 'name'
    when "problem_solver"
      klass = ProblemSolver
    else
      []
    end
    @results = klass.where("#{column} LIKE ?","%#{params[:search]}%")
  end

end
