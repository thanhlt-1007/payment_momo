class Momo::ApplicationService
  include Rails.application.routes.url_helpers
  default_url_options[:host] = ENV["HOST"]

  def initialize order
    @order = order
  end

  protected

  attr_reader :order

  def payment_url
    @payment_url ||= Rails.env.production? ? Settings.momo.payment_url.production : Settings.momo.payment_url.test
  end

  def partner_code
    @partner_code ||= ENV["PARTNER_CODE"]
  end

  def access_key
    @access_key ||= ENV["ACCESS_KEY"]
  end

  def secret_key
    @secret_key ||= ENV["SECRET_KEY"]
  end

  def order_info
    @order_info ||= "Example order with MoMo"
  end

  def return_url
    @return_url ||= momo_payment_url(id: order.id)
  end

  def notify_url
    @notify_url ||= momo_payment_url(id: order.id)
  end

  def amount
    @amount ||= order.price.to_s
  end

  def order_id
    @order_id ||= order.momo_order_id
  end

  def request_id
    @request_id ||= order.momo_request_id
  end

  def request_type
    @request_type ||= Settings.momo.request_type
  end

  def extra_data
    @extra_data ||= ""
  end
end
