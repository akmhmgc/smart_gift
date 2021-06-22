class ProductsController < ApplicationController
  def index
    @q = Product.includes([:store], [{ image_attachment: :blob }]).ransack(params[:q])
    @categories = Category.select(:name, :ancestry, :id)
    @products = @q.result.page(params[:page]).per(10)
  end

  def show
    # 商品と店舗が販売する商品を5つとってくる
    @product = Product.find(params[:id])
    @other_products_top5 = Product.eager_load(:store, image_attachment: :blob).where("store_id = ? and NOT(products.id= ?)", @product.store.id,
                                                                                     @product.id).limit(5)

    @reviews = @product.reviews.eager_load(user: { profile: { image_attachment: :blob } }).page(params[:page]).per(5)
    @blank_review_for_post = current_user.reviews.build if current_user
  end
end
