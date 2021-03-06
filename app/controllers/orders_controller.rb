class OrdersController < ApplicationController
  before_action :authenticate_user!, except: [:giftcard_show]
  before_action :setup_cart_item, only: %i[add_item update_item delete_item]
  before_action :cart_validation, only: %i[giftcard_preview payment]

  def giftcard_show
    @giftcard = Order.where(received: true).find_by!(public_uid: params[:id])
  end

  def giftcard_preview; end

  def giftcard_edit; end

  def giftcard_receive
    giftcard = Order.find_by!(public_uid: params[:id])
    if current_user.receive_giftcard?(giftcard)
      flash[:notice] = 'ギフトの受け取りに成功しました'
      redirect_to mypage_gifts_path
    else
      flash[:alert] = '既にギフトは受け取られています'
      redirect_back(fallback_location: root_path)
    end
  end

  def payment
    current_user.pay!
    flash[:notice] = 'ギフトカードの購入が完了しました'
    session.delete(:messages)
    redirect_to giftcard_path(current_user.cart)
  rescue StandardError
    flash[:alert] = '購入時にエラーが発生しました'
    redirect_to giftcard_preview_path
  end

  def create
    cart_params = params.permit(:message, :sender_name)
    current_cart.attributes = cart_params
    session[:messages] = cart_params
    if current_cart.save(context: :cart_check)
      flash[:notice] = 'ギフトカードが完成しました'
      redirect_to giftcard_preview_path
    else
      flash.now[:alert] = 'ギフトカードの作成に失敗しました'
      render 'giftcard_edit'
    end
  end

  def add_item
    unless @cart_item
      product = Product.find_by(id: params[:product_id])
      @cart_item = current_cart.order_items.build(product_id: params[:product_id],
                                                  price: product.price, product_name: product.name,
                                                  product_image: product.image.blob, store_id: product.store.id)
    end
    @cart_item.quantity += params[:quantity].to_i
    if  @cart_item.save
      flash[:notice] = '商品が追加されました'
      redirect_to giftcard_edit_path
    else
      flash[:alert] = '商品の追加に失敗しました'
      redirect_to product_url(params[:product_id])
    end
  end

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

  def setup_cart_item
    @cart_item = current_cart.order_items.find_by(product_id: params[:product_id])
  end

  def cart_validation
    return unless current_cart.invalid?(:cart_check)

    flash[:alert] = '不正なプレビューです'
    redirect_to root_path
  end
end
