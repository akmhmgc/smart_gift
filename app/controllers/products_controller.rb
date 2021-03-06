class ProductsController < ApplicationController
  def index
    # @products = Product.all.page(params[:page])
    @q = Product.ransack(params[:q])
    @categories = Category.all
    # 子カテゴリにはスペースを挿入
    @categories.each do |cat|
      cat.name.insert(0, '　') if cat.ancestry?
    end
    # 店舗名を含まない検索
    @products = @q.result.page(params[:page])
  end

  def show
    @product = Product.find_by(id: params[:id])
  end
end
