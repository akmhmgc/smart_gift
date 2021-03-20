class ProductsController < ApplicationController
  load_and_authorize_resource

  def index
    @q = @products.with_attached_image.includes(:store).ransack(params[:q])
    @categories = Category.all
    # 子カテゴリにはスペースを挿入
    @categories.each do |cat|
      cat.name.insert(0, '　') if cat.ancestry?
    end
    # 店舗名を含まない検索
    @products = @q.result.page(params[:page])
  end

  def show
    @reviews = @product.reviews.includes(:user).page(params[:page]).per(5)
    @review = current_user.reviews.build if user_signed_in?
  end

  def create; end
end
