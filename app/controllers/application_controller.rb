class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_cart
  def current_cart
    # カートの作成時はvalidationを通さない
    current_user.cart || current_user.create_cart!
  end
end
