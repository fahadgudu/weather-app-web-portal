class Api::V1::ProblemSolversController < ApplicationController

  swagger_controller :problem_solvers, "Problem Solver"

  swagger_api :index do
    summary "Fetches all Problem solvers"
    notes "This lists all the Problem solvers"
    param :query, :access_token, :string, :required, "Access Token"
    response :unauthorized
  end

  def index
    @problem_solvers = ProblemSolver.all.position_asc
  end

  swagger_api :show do
    summary "Returns details of the problem solver"
    notes "Return problem and its resolution."
    param :query, :access_token, :string,  :required, "Access Token"
    param :query, :id,           :integer, :required, "ID"
    response :unauthorized
  end

  def show
    @problem_solver = ProblemSolver.find params[:id]
  end

end
