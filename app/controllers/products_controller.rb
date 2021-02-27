class ProductsController < ApplicationController
  def index
    # @products = Product.all.page(params[:page])
    @q = Product.ransack(params[:q])
    # 店舗名を含まない検索
    @products = @q.result.page(params[:page])
  end

  def show; end
end
