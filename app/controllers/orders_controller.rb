class OrdersController < ApplicationController
  before_action :authenticate_user!, except: [:giftcard_show]
  before_action :setup_cart_item!, only: %i[add_item update_item delete_item]

  def giftcard_show
    @giftcard = Order.find_by!(public_uid: params[:id])
  end

  def giftcard_preview; end

  def giftcard_edit; end

  def giftcard_receive
    @giftcard = Order.find_by!(public_uid: params[:id])

    if @giftcard.recipient_id.nil?
      # 注文完了時間を更新しない
      @giftcard.recipient_id = current_user.id
      @giftcard.record_timestamps = false
      @giftcard.save
      flash[:notice] = 'ギフトの受け取りに成功しました'
      redirect_to mypage_gifts_path
    else
      flash[:alert] = '既にギフトは受け取られています'
      redirect_to root_path
    end
  end

  def payment
    current_user.payment
    flash[:notice] = 'ギフトカードの購入が完了しました'
    redirect_to giftcard_path(current_user.cart)
  rescue StandardError
    flash[:alert] = 'ご利用可能な金額を越えています。商品数を減らすかプロフィール画面よりチャージしてください。'
    redirect_to giftcard_preview_path
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
      respond_to do |format|
        format.html { redirect_to giftcard_edit_path, notice: 'カート内のギフトが更新されました' }
        format.js { flash.now[:notice] = 'カート内のギフトが更新されました' }
      end
    else
      flash[:alert] = 'カート内のギフトの更新に失敗しました'
      redirect_to giftcard_edit_path
    end
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
