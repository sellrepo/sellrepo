class ProductsController < ApplicationController
  before_action :set_product, only: [:show]

  def index
    @pagy, @products = pagy Product.all
  end

  def show
  end

  private

  def set_product
    @product = Product.find_by!(slug: params[:id])
  end
end
