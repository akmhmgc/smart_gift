class StoresController < ApplicationController
  # before_action :authenticate_store!
  def show
    @store = Store.find_by(id: params[:id])
  end
end
