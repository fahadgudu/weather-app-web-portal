class Api::V1::CategoriesController < ApplicationController

  def index
    @categories = Category.top
  end

  def show
    @category = Category.find params[:id]
    @sub_categories = @category.sub_categories
  end

end
