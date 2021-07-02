class  Mypage::OrdersController < ApplicationController
  before_action :authenticate_user!
  def order_show
    @order = Order.find_by(id: params[:order_id])
    respond_to do |format|
      format.html { redirect_to mypage_order_pdf_path(format: :pdf, debug: 1, order_id: params[:order_id]) }
      format.pdf do
        if params[:debug].present?
          render pdf: "order_#{@order.id}",
                 encoding: 'UTF-8',
                 layout: 'pdf',
                 template: 'mypage/orders/order_show',
                 show_as_html: true
        else
          filename = "order_#{@order.id}-#{l Date.current, format: :file}.pdf"
          pdf = render_to_string pdf: filename,
                                 template: 'mypage/orders/order_show',
                                 encoding: 'UTF-8',
                                 layout: 'pdf'
          send_data(pdf, filename: filename)
        end
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
