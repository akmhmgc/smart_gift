class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :setup_cart_item!, only: %i[add_item update_item delete_item]

  def giftcard_preview; end

  def giftcard_edit; end

  def payment
  end

  def create
    if current_cart.update(message: params[:message], sender_name: params[:sender_name])
      flash[:notice] = 'ギフトカードが完成しました。'
      redirect_to giftcard_preview_path
    else
      flash.now[:alert] = 'ギフトカードの作成に失敗しました。'
      render 'giftcard_edit'
    end
  end

  # アイテムの追加
  def add_item
    # カートに入れた時点での値段を記録する
    unless @cart_item
      price = Product.find_by(id: params[:product_id]).price
      @cart_item = current_cart.order_items.build(product_id: params[:product_id], price: price)
    end

    @cart_item.quantity += params[:quantity].to_i
    if  @cart_item.save
      flash[:notice] = '商品が追加されました。'
      redirect_to giftcard_edit_path
    else
      flash[:alert] = '商品の追加に失敗しました。'
      redirect_to product_url(params[:product_id])
    end
  end

  # アイテムの更新
  def update_item
    if @cart_item.update(quantity: params[:quantity].to_i)
      flash[:notice] = 'カート内のギフトが更新されました'
    else
      flash[:alert] = 'カート内のギフトの更新に失敗しました'
    end
    redirect_to giftcard_edit_path
  end

  # アイテムの削除
  def delete_item
    if @cart_item.destroy
      flash[:notice] = 'カート内のギフトが削除されました'
    else
      flash[:alert] = '削除に失敗しました'
    end
    redirect_to giftcard_edit_path
  end

  private

  def setup_cart_item!
    @cart_item = current_cart.order_items.find_by(product_id: params[:product_id])
  end
end
