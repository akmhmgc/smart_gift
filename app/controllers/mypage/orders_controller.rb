class  Mypage::OrdersController < ApplicationController
  before_action :authenticate_user!
  def orders_show
    @order = Order.find_by!(user_id: current_user.id, id: params[:id])
    @order_items = @order.order_items
  end

  def orders_index
    @orders = current_user.orders.includes([:order_items])
  end
end
