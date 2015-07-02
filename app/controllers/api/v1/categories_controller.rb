class Api::V1::CategoriesController < ApplicationController

  swagger_controller :growing_guides, "Categories"

  swagger_api :index do
    summary "Returns all the categories"
    notes "This lists all the parent categories"
    param :query, :access_token, :string, :required, "Access Token"
    param :query, :tree, :string, :optional, "Optional parameter to show the whole tree of sub categories and products"
    response :unauthorized
  end

  def index
    @categories = Category.top.includes([:banner, {sub_categories: [:products, :banner]}] )
  end

  swagger_api :show do
    summary "Returns the sub-category of a particular parent category"
    notes "Returns the sub-category of a particular parent category"
    param :query, :access_token, :string, :required, "Access Token"
    param :query, :id,           :integer, :required, "ID of the category"
    response :unauthorized
  end

  def show
    @category = Category.find params[:id]
    @sub_categories = @category.sub_categories
  end

end
