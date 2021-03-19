class ProductsController < ApplicationController
  def index
    @q = Product.where(publish: true).with_attached_image.includes(:store).ransack(params[:q])
    @categories = Category.all
    # 子カテゴリにはスペースを挿入
    @categories.each do |cat|
      cat.name.insert(0, '　') if cat.ancestry?
    end
    # 店舗名を含まない検索
    @products = @q.result.page(params[:page])
  end

  def show
    @product = Product.find(params[:id])
    check_product_published(@product)
    @reviews = @product.reviews.includes(:user).page(params[:page]).per(5)
    @review = current_user.reviews.build if user_signed_in?
  end

  def create; end
end
