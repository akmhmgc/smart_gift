class StoresController < ApplicationController
  def show
    @store = Store.find(params[:id])
    # showでアイテム表示
  end

  def items
    @store = Store.find(params[:store_id])
    @items = @store.products.with_attached_image
  end
end
