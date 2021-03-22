class ReviewsController < ApplicationController
  before_action :authenticate_user!

<<<<<<< HEAD
  def create
    if @review.save
      flash[:notice] = 'レビューが投稿されました'
=======
    # notification
    product = Product.find(params[:review][:product_id])
    product.create_notification_review!(current_user, @review.id)
>>>>>>> system-tests

      # notification
      product = Product.find(params[:review][:product_id])
      product.create_notification_review!(current_user, @review.id)
    else
      flash[:alert] = 'レビューの投稿に失敗しました。'
    end
    redirect_back(fallback_location: root_url)
  end
  
  def destroy
    if @review.destroy
      redirect_to root_path, notice: '削除に成功しました'
    else
      flash[:alert] = '削除に失敗しました。'
      redirect_to restaurant_review_path(id: @review.id)
    end
  end

  private

  def review_params
    params.require(:review).permit(:product_id, :title, :body)
  end
end
