class RedeemifyCodesController < ApplicationController

  before_action :set_code, only: [:show]

  def show
    # TODO: CHECK THAT CODE IS OWNED BY THE USER: if redeemify_codes_params[:code]...
    render json: @code
  end

  private

  def set_code
    if current_user then
     @code = VendorCode.find_by user_id: current_user
    end
  end

  def redeemify_code_params
    #ActiveModelSerializers::Deserialization.jsonapi_parse(params)
    params.permit(:code)
  end
end