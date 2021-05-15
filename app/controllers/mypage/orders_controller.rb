class  Mypage::OrdersController < ApplicationController
  before_action :authenticate_user!
  def orders_show
    @order = Order.find_by!(user_id: current_user.id, id: params[:id], received: true)
    @order_items = @order.order_items
  end

  def orders_index
    @orders = current_user.orders.includes([{ order_items:  { product_image_attachment: :blob } }], [order_items: :product]).page(params[:page]).per(5)
  end

  def gifts_index
    @gifts = current_user.giftcards.includes([{ order_items:  { product_image_attachment: :blob } }], [order_items: :product])
                         .page(params[:page]).reorder(received_at: :desc).per(5)
  end
end
