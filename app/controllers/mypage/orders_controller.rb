class  Mypage::OrdersController < ApplicationController
  before_action :authenticate_user!
  def order_show
    @id = params[:order_id]
    @params = params
    respond_to do |format|
      format.html { redirect_to mypage_order_pdf_path(format: :pdf, debug: 1, order_id: @id) }
      format.pdf do
        render pdf: 'report_pdf',
               encoding: 'UTF-8',
               layout: 'pdf',
               template: 'mypage/orders/order_show',
               show_as_html: params[:debug].present?
      end
    end
  end

  def orders_index
    @orders = current_user.orders.includes([{ order_items:  { product_image_attachment: :blob } }], [order_items: :product]).page(params[:page]).per(5)
  end

  def gifts_index
    @gifts = current_user.giftcards.includes([{ order_items:  { product_image_attachment: :blob } }], [order_items: :product])
                         .page(params[:page]).reorder(received_at: :desc).per(5)
  end
end
