class ProductsController < ApplicationController
  def index
    @q = Product.includes([:store], [{ image_attachment: :blob }]).ransack(params[:q])
    @categories = Category.select(:name, :ancestry)
    @products = @q.result.page(params[:page])
  end

  def show
    @product = Product.find(params[:id])
    @reviews = @product.reviews.eager_load(user: { profile: { image_attachment: :blob } }).page(params[:page]).per(5)
    @review = current_user.reviews.build if user_signed_in?
    @other_products = Product.eager_load(:store, image_attachment: :blob).where("store_id = ? and NOT(id= ?)", @product.store.id, @product.id).limit(5)
  end
end
