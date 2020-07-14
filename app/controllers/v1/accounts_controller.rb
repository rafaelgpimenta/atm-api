class V1::AccountsController < ApplicationController
  before_action :authorize_access_request!

  def my
    render json: account
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def account
    @account ||= current_customer.account
  end
end
