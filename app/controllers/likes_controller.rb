class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @product = Product.find(params[:product_id])
    current_user.like(@product)

    # norification
    @product.create_notification_like!(current_user)
    respond_to do |format|
      format.html { redirect_to current_user }
      format.js { flash.now[:notice] = "商品がお気に入りに追加されました。お気に入りページで確認できます。" }
    end
  end

  def destroy
    @product = Like.find(params[:id]).product
    current_user.unlike(@product)
    respond_to do |format|
      format.html { redirect_to current_user }
      format.js { flash.now[:notice] = "商品がお気に入りから削除されました" }
    end
  end
end
