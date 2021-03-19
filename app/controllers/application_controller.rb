class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def check_product_published(product)
    return if product.publish?

    flash[:alert] = '存在しないURLです'
    redirect_to root_path
  end
end
