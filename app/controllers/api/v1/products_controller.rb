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
    param :query, :latitude,     :float, :required, "Latitude of center"
    param :query, :longitude,    :float, :required, "Longitude of center"
    param :query, :distance,     :integer, :optional, "Dsitance"
    param :query, :company,      :string, :optional, "Name of the company to filter results for"
    response :unauthorized
  end

  def show
    @product = @category.products.includes(:stores, :usages, :instructions).find params[:id]
    @stores  = @product.stores
    @stores  = @stores.where(places_id: Places.new(params[:latitude], params[:longitude]).search(params[:distance] || Store::RADIUS)) if params[:latitude].present? && params[:longitude].present?
    @stores  = @stores.joins(:company).where('companies.name = ?', params[:company]) if params[:company].present?
    @companies = Company.all
  end

  protected

  def set_category
    @category = Category.find params[:category_id]
  end

end
