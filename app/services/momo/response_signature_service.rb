class Momo::ResponseSignatureService < Momo::ApplicationService
  def initialize order, params
    @order = order
    @params = params
  end

  def perform
    digest = OpenSSL::Digest.new("sha256")
    OpenSSL::HMAC.hexdigest(digest, secret_key, raw_signature)
  end

  private

  attr_reader :params

  def raw_signature
    "partnerCode=" + params[:partnerCode] +
      "&accessKey=" + params[:accessKey] +
      "&requestId=" + params[:requestId] +
      "&amount=" + params[:amount] +
      "&orderId=" + params[:orderId] +
      "&orderInfo=" + params[:orderInfo] +
      "&orderType=" + params[:orderType] +
      "&transId=" + params[:transId] +
      "&message=" + params[:message] +
      "&localMessage=" + params[:localMessage] +
      "&responseTime=" + params[:responseTime] +
      "&errorCode=" + params[:errorCode] +
      "&payType=" + params[:payType] +
      "&extraData=" + params[:extraData]
  end
end
