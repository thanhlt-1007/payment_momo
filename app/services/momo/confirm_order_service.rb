class Momo::ConfirmOrderService < Momo::ApplicationService
  attr_reader :success

  def initialize order, params
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
    return @success = false if signature != params[:signature]
  end

  private

  attr_reader :params

  def signature
    @signature ||= Momo::ResponseSignatureService.new(order, params).perform
  end
end
