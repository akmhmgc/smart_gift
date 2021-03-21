class Dashboard::ProductController < ApplicationController
  before_action :authenticate_store!
  def index
    # store_id == current_store.idの商品のみ表示
  end
end
