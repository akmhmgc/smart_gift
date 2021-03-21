class StoresController < ApplicationController
  def show
    @store = Store.find(params[:id])
  end

  def items
    @store = Store.find(params[:store_id])
    @items = @store.products.with_attached_image
  end
end
