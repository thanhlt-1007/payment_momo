class Momo::SendRequestService < Momo::ApplicationService
  attr_reader :success, :pay_url, :error_message

  def perform
    load_uri_and_http
    load_request
    send_request

    @success = @result["errorCode"] == 0
    if @success
      @pay_url = @result["payUrl"]
    else
      @error_message = @result["localMessage"]
    end
  end

  private

  def load_uri_and_http
    @uri = URI.parse payment_url

    @http = Net::HTTP.new @uri.host, @uri.port
    @http.use_ssl = true
    @http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  end

  def load_request
    @request = Net::HTTP::Post.new @uri.path
    @request.add_field "Content-Type", "application/json"
    @request.body = body_object.to_json
  end

  def send_request
    @response = @http.request @request
    @result = JSON.parse @response.body
  end

  def body_object
    @body_object ||= Momo::BodyObjectService.new(order, signature).perform
  end

  def signature
    @signature ||= Momo::SignatureService.new(order).perform 
  end
end
