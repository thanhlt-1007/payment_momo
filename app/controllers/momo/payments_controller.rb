class Momo::PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: %i(update)

  before_action :load_product, only: %i(create)
  before_action :authenticate_payment_success, only: %i(show update)
  before_action :load_order, only: %i(show update)

  def create
    order = @product.create_order price: @product.price,
      momo_order_id: SecureRandom.hex,
      momo_request_id: SecureRandom.hex

    service = Momo::SendRequestService.new(order)
    service.perform

    if service.success
      redirect_to service.pay_url
    else
      order.destroy

      flash[:danger] = service.error_message
      redirect_to root_url
    end
  end

  def show
    confirm_and_update_order
  end

  def update
    confirm_and_update_order
  end

  private

  def load_product
    @product = Product.find_by(id: params[:product_id])
    return if @product

    flash[:danger] = "Product not found"
    redirect_to root_url
  end

  def authenticate_payment_success
    return if params[:errorCode] == "0"

    flash[:danger] = params[:localMessage]
    redirect_to root_url
  end

  def load_order
    @order = Order.find_by id: params[:id]
    return if @order

    flash[:danger] = "Order not found"
    redirect_to root_url
  end

  def confirm_and_update_order
    confirm_service = Momo::ConfirmOrderService.new @order, params
    confirm_service.perform

    if confirm_service.success
      update_service = Momo::UpdateOrderService.new @order, params
      update_service.perform

      flash[:success] = "Payment success"
      redirect_to root_url # order_url(@order)
    else
      @order.destroy

      flash[:danger] = "Incorrect MoMo Response"
      redirect_to root_url
    end
  end
end
