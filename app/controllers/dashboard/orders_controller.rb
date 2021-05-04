class Dashboard::OrdersController < ApplicationController
  before_action :authenticate_store!
  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items.preload(product: { image_attachment: :blob })
  end

  def report
    @month = params[:month] ? Date.parse(params[:month]) : Time.zone.today
    order_items = OrderItem.belongs_to_store(current_store).where(updated_at: @month.all_month)
    @data = order_items.group_by_day(:created_at).sum("order_items.price*quantity")
    @total = order_items.sum("order_items.price*quantity")

    @rank_hash = order_items.group(:product_id).order("sum(quantity) desc").limit(5).sum(:quantity)
    product_ids = @rank_hash.keys
    @products = Product.find(product_ids)

    @orders = Order.belongs_to_store(current_store).where(updated_at: @month.all_month).page(params[:page]).per(20)
  end
end
