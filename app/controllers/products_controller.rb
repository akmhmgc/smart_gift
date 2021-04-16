class ProductsController < ApplicationController
  def index
    @q = Product.with_attached_image.includes(store: { image_attachment: :blob }).ransack(params[:q])
    @categories = Category.all

    # 子カテゴリにはスペースを挿入
    @categories.each do |cat|
      cat.name.insert(0, '　') if cat.ancestry?
    end

    @products = @q.result.page(params[:page])

    # 検索時の値段範囲
    price_range = [100,300,500,1000,2000,3000,4000,5000].map { |n| ["¥#{n.to_s}", n] }.to_h
    @price_range_low = {"下限なし":0}.merge(price_range)
    @price_range_high = price_range.merge({"上限なし":999_999_999})
  end

  def show
    @product = Product.find(params[:id])
    @reviews = @product.reviews.includes(user: { profile: { image_attachment: :blob } }).page(params[:page]).per(5)
    @review = current_user.reviews.build if user_signed_in?
  end
end
