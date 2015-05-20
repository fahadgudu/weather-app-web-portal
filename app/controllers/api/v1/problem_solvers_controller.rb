class Api::V1::ProblemSolversController < ApplicationController

  def index
    @problem_solvers = ProblemSolver.all
  end

  def show
  end

end
