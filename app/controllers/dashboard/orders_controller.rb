class Dashboard::OrdersController < ApplicationController
  require 'csv'
  before_action :authenticate_store!
  def show
    @order = Order.find(params[:id])
    @total = @order.total_price_for_store(current_store)
    @order_items = @order.order_items.eager_load([:product], [{ product_image_attachment: :blob }]).where("order_items.store_id = ?", current_store.id)
  end

  def report
    @month = params[:month] ? Date.parse(params[:month]) : Time.zone.today
    monthly_orders = Order.belongs_to_store(current_store).where(updated_at: @month.all_month)

    # 月次の日毎の売り上げと月次トータル売り上げ
    @monthly_total = monthly_orders.sum("order_items.price*quantity")
    @sales_by_day = monthly_orders.group_by_day("order_items.updated_at").sum("order_items.price*quantity")

    # 売り上げ個数によるランキング
    @product_ranked = monthly_orders.joins(order_items: :product).group(:product_id)
                                    .select("products.id", "products.name", "products.price",
                                            "sum(quantity) as sum_quantity").reorder("sum(quantity) desc").limit(5)

    # 注文ごとの合計金額
    @order_totals = monthly_orders.group("orders.id").select("orders.id", "profiles.name", "orders.updated_at",
                                                             "sum(order_items.price*quantity) as sum_total").page(params[:page]).per(20)
  end

  def sales_history
    @month = Date.parse(params[:month])
    monthly_orders = Order.belongs_to_store(current_store).where(updated_at: @month.all_month)
    @order_totals = monthly_orders.group("orders.id").select("orders.id", "profiles.name", "orders.updated_at",
                                                             "sum(order_items.price*quantity) as sum_total")
    respond_to do |format|
      format.html
      format.csv do |_csv|
        send_orders_csv(@order_totals, @month)
      end
    end
  end

  private

  def send_orders_csv(orders, datetime)
    csv_data = CSV.generate do |csv|
      column_names = %w[購入日 注文id 購入者 注文合計金額]
      csv << column_names
      orders.each do |order|
        column_values = [
          order.updated_at,
          order.id,
          order.name || "削除されたユーザー",
          order.sum_total
        ]
        csv << column_values
      end
    end
    send_data(csv_data, filename: "sales_history-#{l datetime, format: :file_short}.csv")
  end
end
