class ReviewsController < ApplicationController
  before_action :review_setup, only: %i[edit update]
  before_action :authenticate_user!
  before_action :correct_user, only: %i[edit update]

  def create
    @review = current_user.reviews.build(review_params)
    @product = Product.find(params[:review][:product_id])
    if @review.save
      # notification
      @product.create_notification_review!(current_user, @review.id)
      flash[:notice] = 'レビューが投稿されました'
      redirect_to @product
    else
      @reviews = @product.reviews.includes(:user).page(params[:page]).per(5)
      flash.now[:alert] = 'レビューの投稿に失敗しました。詳細はタイトル入力欄上のエラーメッセージをご確認ください。'
      render 'products/show'
    end
  end

  def edit; end

  def update
    if @review.update(review_params)
      flash[:notice] = 'レビューが変更されました'
      redirect_to @review.product
    else
      flash.now[:alert] = 'レビューの更新に失敗しました。詳細はメッセージをご確認ください。'
      render 'edit'
    end
  end

  def destroy
    @review = Review.find(params[:id])
    if @review.destroy
      flash[:notice] = '削除に成功しました'
    else
      flash[:alert] = '削除に失敗しました。'
    end
    redirect_to @review.product
  end

  private

  def review_setup
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:product_id, :title, :body, :stars)
  end

  # 正しいユーザーかどうか確認
  def correct_user
    return unless @review.user != current_user

    flash[:alert] = '無効なURLです'
    redirect_back(fallback_location: @review.product)
  end
end
