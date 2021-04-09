class ProductsController < ApplicationController
  def index
    @q = Product.with_attached_image.includes(store: { image_attachment: :blob }).ransack(params[:q])
    @categories = Category.all

    # 子カテゴリにはスペースを挿入
    @categories.each do |cat|
      cat.name.insert(0, '　') if cat.ancestry?
    end
    
    @products = @q.result.page(params[:page])
  end

  def show
    @product = Product.find(params[:id])
    @reviews = @product.reviews.includes(:user).page(params[:page]).per(5)
    @review = current_user.reviews.build if user_signed_in?
  end
end
