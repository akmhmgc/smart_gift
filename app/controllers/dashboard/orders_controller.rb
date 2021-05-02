class Dashboard::OrdersController < ApplicationController
  before_action :authenticate_store!
  def index
    # 関連モデルも同時
    @orders = Order.includes(order_items: :product).where(order_items: { products: { store_id: current_store.id } })
  end

  def show
  end

  def report
    @month = params[:month] ? Date.parse(params[:month]) : Time.zone.today
    order_items = OrderItem.includes(:product).where(products: { store_id: current_store.id }).where(updated_at: @month.all_month)
    @data = order_items.group_by_day(:created_at).sum("order_items.price*quantity")
    @total = order_items.sum("order_items.price*quantity")
    # @orders = Order.includes(order_items: :product).where(order_items: { products: { store_id: current_store.id } })

    # 売り上げ上位のproduct_idと売り上げ個数
    @rank_hash = order_items.group(:product_id).order("sum(quantity) desc").limit(5).sum(:quantity)
    product_ids = @rank_hash.keys
    @products = Product.find(product_ids)
  end
end
