class Api::V1::ProblemSolversController < ApplicationController

  def index
    @problem_solvers = ProblemSolver.all
  end

  def show
    @problem_solver = ProblemSolver.find params[:id]
  end

end
