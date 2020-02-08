class Momo::ConfirmOrderService < Momo::ApplicationService
  attr_reader :success

  def initialize order,params
    @order = order
    @params = params
    @success = true
  end
 
  def perform
    return @success = false if partner_code != params[:partnerCode]
    return @success = false if access_key != params[:accessKey]
    return @success = false if request_id != params[:requestId]
    return @success = false if amount != params[:amount]
    return @success = false if order_id != params[:orderId] 
  end

  private

  attr_reader :params
end
