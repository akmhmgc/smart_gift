class ProductsController < ApplicationController
  def index
    @products = Product.all.page(params[:page])
  end

  def show; end
end
