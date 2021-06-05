class Dashboard::OrdersController < ApplicationController
  before_action :authenticate_store!
  def show
    @order = Order.find(params[:id])
    @total = @order.total_price_for_store(current_store)
    @order_items = @order.order_items.eager_load([:product], [{ product_image_attachment: :blob }]).where("order_items.store_id = ?", current_store.id)
  end

  def report
    @month = params[:month] ? Date.parse(params[:month]) : Time.zone.today
    order_items = current_store.order_items.where(updated_at: @month.all_month)
    @data = order_items.group_by_day(:updated_at).sum("order_items.price*quantity")
    @total = order_items.sum("order_items.price*quantity")

    @rank_hash = order_items.where.not(product_id: nil).group(:product_id).order("sum(quantity) desc").limit(5).sum(:quantity)
    product_ids = @rank_hash.keys
    @top_selling_products = Product.where(id:product_ids)

    @orders = Order.belongs_to_store(current_store).where(updated_at: @month.all_month).page(params[:page]).per(20)
    @order_totals = @orders.joins(:order_items).where("store_id =?",
                                                      current_store).group("orders.id").pluck(Arel.sql("orders.id, sum(order_items.price*quantity)")).to_h
  end
end
