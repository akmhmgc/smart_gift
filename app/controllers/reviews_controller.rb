class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: :destroy
  def create
    @review = current_user.reviews.create!(review_params)
    flash[:notice] = 'レビューが投稿されました'

    # notification
    product = Product.find(params[:review][:product_id])
    product.create_notification_review!(current_user, @review.id)

    redirect_to @review.product
  end

  def destroy
    @review.destroy
    flash[:notice] = 'レビューが削除されました'
    redirect_to request.referer || root_url
  end

  private

  def review_params
    params.require(:review).permit(:product_id, :title, :body)
  end

  def correct_user
    @review = current_user.reviews.find_by(id: params[:id])
    redirect_to root_url if @review.nil?
  end
end
