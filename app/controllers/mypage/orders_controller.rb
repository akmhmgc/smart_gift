class  Mypage::OrdersController < ApplicationController
  before_action :authenticate_user!
  def orders_show
    @order = Order.find_by!(user_id: current_user.id, id: params[:id], recieved: true)
    @order_items = @order.order_items
  end

  def orders_index
    @orders = current_user.orders.preload(order_items: { product: { image_attachment: :blob } }).page(params[:page]).per(5)
  end

  def gifts_index
    @gifts = Order.where(recipient_id: current_user.id, recieved: true).includes([:order_items])
  end

  def gifts_showre
    @gift = Order.find_by!(recipient_id: current_user.id, id: params[:id], recieved: true)
  end
end
