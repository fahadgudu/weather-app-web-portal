class Api::V1::ProductsController < ApplicationController

  before_action :set_category

  swagger_controller :products, "Products"

  swagger_api :index do
    summary "Returns the products of a specific category"
    notes "This lists all the products of a specific category"
    param :query, :access_token, :string, :required, "Access Token"
    param :query, :category_id,  :integer, :required, "ID of the category"
    response :unauthorized
  end

  def index
    @products = @category.products
  end

  swagger_api :show do
    summary "Returns the deails of a particular product"
    notes "This display details of a particular product"
    param :query, :access_token, :string, :required, "Access Token"
    param :query, :category_id,  :integer, :required, "ID of the category"
    param :query, :id,           :integer, :required, "ID of the product"
    response :unauthorized
  end

  def show
    @product = @category.products.includes(:stores, :usages, :instructions).find params[:id]
  end

  protected

  def set_category
    @category = Category.find params[:category_id]
  end

end