class Dashboard::OrdersController < ApplicationController
  before_action :authenticate_store!
  def index
    # 関連モデルも同時
    @orders = Order.includes(order_items: :product).where(order_items: { products: { store_id: current_store.id } })
  end

  def show
  end
end
