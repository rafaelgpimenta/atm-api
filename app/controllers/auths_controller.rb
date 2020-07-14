class AuthsController < ApplicationController
  before_action :authorize_access_request!, only: [:sign_out]
  before_action :authorize_refresh_by_access_request!, only: [:refresh]

  def sign_up
    customer = Customer.new(customer_params)
    account = CheckingAccount.new(customer: customer)

    if account.save
      tokens = generate_tokens(customer)
      # set_jwt_cookie(tokens)

      render json: { access: tokens[:access] }, status: :created
    else
      errors = (account.customer.errors.full_messages + account.errors.full_messages).join(', ')
      render json: { error: errors }, status: :unprocessable_entity
    end
  end

  def sign_in
    customer = Customer.find_by(cpf: params[:cpf])
    return not_authorized unless customer.authenticate(params[:password])

    tokens = generate_tokens(customer)
    # set_jwt_cookie(tokens)
    render json: { access: tokens[:access] }
  end

  def sign_out
    session = JWTSessions::Session.new(payload: payload)
    session.flush_by_access_payload
    render json: :ok
  end

  def refresh
    session = JWTSessions::Session.new(payload: claimless_payload, refresh_by_access_allowed: true)
    tokens = session.refresh_by_access_payload do
      # here goes malicious activity alert
      raise JWTSessions::Errors::Unauthorized, "Refresh action is performed before the expiration of the access token."
    end
    # set_jwt_cookie(tokens)

    render json: { access: tokens[:access] }
  end

  private

  # def set_jwt_cookie(tokens)
  #   response.set_cookie(
  #     JWTSessions.access_cookie,
  #     value: tokens[:access],
  #     httponly: true,
  #     secure: Rails.env.production?,
  #   )
  # end

  def generate_tokens(customer)
    payload = { customer_id: customer.id }
    session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
    session.login
  end

  def customer_params
    params.permit(:cpf, :password, :password_confirmation)
  end

  def not_found
    render json: { error: 'Customer not found' }, status: :not_found
  end
end
