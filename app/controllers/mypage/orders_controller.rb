class  Mypage::OrdersController < ApplicationController
  before_action :authenticate_user!
  def orders_show
    @order = Order.find_by!(user_id: current_user.id, id: params[:id], received: true)
    @order_items = @order.order_items
  end

  def orders_index
    @orders = current_user.orders.with_product_images.page(params[:page]).per(5)
  end

  def gifts_index
    @gifts = current_user.giftcards.with_product_images.page(params[:page]).per(5)
  end
end
