class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])
  end

  def favorites
    product_ids = Like.where(user_id: params[:id]).select(:product_id)
    @products = Product.where(id: product_ids).includes(:store, image_attachment: :blob).page(params[:page])
  end
end
