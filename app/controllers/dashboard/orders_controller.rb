class Dashboard::OrdersController < ApplicationController
  before_action :authenticate_store!
  def index
    # 関連モデルも同時
    @orders = Order.includes(order_items: :product).where(order_items: { products: { store_id: current_store.id } })
  end

  def show
  end

  def report
    # year-monthで渡す 値がない場合は？
    from = params[:year_month] ? Time.local(params[:year_month][0..3], params[:year_month][4..5], 1, 0, 0, 0, 0) : Time.current.at_beginning_of_day 
    to = from + 1.month
    @order_items = OrderItem.includes(:product).where(products: { store_id: current_store.id }).where(updated_at: from...to)
    @orders = Order.includes(order_items: :product).where(order_items: { products: { store_id: current_store.id } })
  end
end
