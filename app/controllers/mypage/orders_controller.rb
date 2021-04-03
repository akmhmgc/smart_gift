class  Mypage::OrdersController < ApplicationController
  before_action :authenticate_user!
  def orders_show
    @order_items = Order.find_by!(user_id: current_user.id, id: params[:id]).order_items.includes([:product])
  end
end
