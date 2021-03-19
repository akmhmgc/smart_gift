class StoresController < ApplicationController
  def show
    @store = Store.find(params[:id])
  end

  def items
    @store = Store.find(params[:store_id])
    # 自分の店舗の商品は非公開アイテムも確認可能
    @items = if current_store == @store
               @store.products.with_attached_image
             else
               @store.products.where(publish: true).with_attached_image
             end
  end
end
