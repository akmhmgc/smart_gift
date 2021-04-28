class ProductsController < ApplicationController
  PRICE_RANGE_ARRAY = [100, 300, 500, 1000, 2000, 3000, 4000, 5000].index_by { |n| "¥#{n}" }
  PRICE_RANGE_ARRAY.freeze

  def index
    @q = Product.with_attached_image.includes(:store).ransack(params[:q])
    @categories = Category.select(:name, :ancestry)

    # 子カテゴリにはスペースを挿入
    @categories.each do |cat|
      cat.name.insert(0, '　') if cat.ancestry?
    end

    @products = @q.result.page(params[:page])
    @price_range_low = { "下限なし": 0 }.merge(PRICE_RANGE_ARRAY)
    @price_range_high = PRICE_RANGE_ARRAY.merge({ "上限なし": 999_999_999 })
  end

  def show
    @product = Product.find(params[:id])
    @reviews = @product.reviews.includes(user: { profile: { image_attachment: :blob } }).page(params[:page]).per(5)
    @review = current_user.reviews.build if user_signed_in?
    @other_products = Product.includes(:store, image_attachment: :blob).where("store_id = ? and NOT(id= ?)", @product.store.id, @product.id).limit(5)
  end
end
