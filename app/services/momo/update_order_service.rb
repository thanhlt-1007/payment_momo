class Momo::UpdateOrderService < Momo::ApplicationService
  def initialize order, params
    @order = order
    @params = params
  end

  def perform
    order.update_attributes order_params
  end

  private

  attr_reader :params

  def order_params
    {
      momo_order_type: params[:orderType],
      momo_pay_type: params[:payType],
      momo_trans_id: params[:transId],
      momo_response_time: Time.zone.parse(params[:responseTime])
    }
  end
end
