class StoresController < ApplicationController
  def show
    @store = Store.find(params[:id])
    @products = @store.products.with_attached_image.page(params[:page]).per(10)
  end
end
