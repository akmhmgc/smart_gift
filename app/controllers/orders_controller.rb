class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :setup_cart_item!, only: %i[add_item update_item delete_item]

  def preview; end

  # カート内アイテムの表示
  def my_cart
    @cart_items = current_cart.order_items.includes([:product])
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
  end

  # アイテムの追加
  def add_item
    # カートに入れた時点での値段を記録する
    unless @cart_item
      price = Product.find_by(id: params[:product_id]).price
      @cart_item = current_cart.order_items.build(product_id: params[:product_id], price: price)
    end

    @cart_item.quantity += params[:quantity].to_i
    if  @cart_item.save
      flash[:notice] = '商品が追加されました。'
      redirect_to my_cart_path
    else
      flash[:alert] = '商品の追加に失敗しました。'
      redirect_to product_url(params[:product_id])
    end
  end

  # アイテムの更新
  def update_item
    if @cart_item.update(quantity: params[:quantity].to_i)
      flash[:notice] = 'カート内のギフトが更新されました'
    else
      flash[:alert] = 'カート内のギフトの更新に失敗しました'
    end
    redirect_to my_cart_path
  end

  # アイテムの削除
  def delete_item
    if @cart_item.destroy
      flash[:notice] = 'カート内のギフトが削除されました'
    else
      flash[:alert] = '削除に失敗しました'
    end
    redirect_to my_cart_path
  end

  private

  def current_cart
    # カートの作成時はvalidationを通さない
    current_user.cart || current_user.create_cart!
  end

  def setup_cart_item!
    @cart_item = current_cart.order_items.find_by(product_id: params[:product_id])
  end
end
