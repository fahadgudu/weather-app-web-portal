class Api::V1::ProductsController < ApplicationController

  before_action :set_category

  def index
    @products = @category.products
  end

  def show
    @product = @category.products.includes(:stores, :usages, :instructions).find params[:id]
  end

  protected

  def set_category
    @category = Category.find params[:category_id]
  end

end
