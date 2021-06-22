class Dashboard::OrdersController < ApplicationController
  before_action :authenticate_store!
  def show
    @order = Order.find(params[:id])
    @total = @order.total_price_for_store(current_store)
    @order_items = @order.order_items.eager_load([:product], [{ product_image_attachment: :blob }]).where("order_items.store_id = ?", current_store.id)
  end

  def report
    # 月次の売り上げ総額、 日毎の売り上げ額
    @day_included_in_monthly_report = params[:month] ? Date.parse(params[:month]) : Time.zone.today
    order_items_within_period = current_store.order_items.where(updated_at: @day_included_in_monthly_report.all_month)
    @sales_by_day = order_items_within_period.group_by_day(:updated_at).sum("order_items.price*quantity")
    @monthly_sales = order_items_within_period.sum("order_items.price*quantity")

    # 売り上げ個数上位5の{product_id:売り上げ個数}
    @rank_hash = order_items_within_period.where.not(product_id: nil).group(:product_id).order("sum(quantity) desc").limit(5).sum(:quantity)
    product_ids = @rank_hash.keys
    @top_selling_products = Product.where(id: product_ids)

    @orders = Order.belongs_to_store(current_store).where(updated_at: @day_included_in_monthly_report.all_month).page(params[:page]).per(20)
    # order_idと合計金額のhash
    @order_id_and_total_sales_hash = @orders.joins(:order_items).where("store_id =?",
                                                                       current_store).group("orders.id")
                                            .pluck(Arel.sql("orders.id, sum(order_items.price*quantity)")).to_h
  end
end
