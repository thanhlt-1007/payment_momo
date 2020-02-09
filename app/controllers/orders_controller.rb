class OrdersController < ApplicationController
  before_action :load_order, only: %i(show)

  def show
    @product = @order.product
  end

  private

  def load_order
    @order = Order.find_by id: params[:id]
    return if @order

    flash[:danger] = "Order not found"
    redirect_to root_url
  end
end
