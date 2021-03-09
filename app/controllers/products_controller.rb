class ProductsController < ApplicationController
  def index
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
    @reviews = @product.reviews.page(params[:page]).per(5)
    @review = current_user.reviews.build if user_signed_in?
  end
end
