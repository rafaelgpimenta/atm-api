class AuthsController < ApplicationController
  before_action :authorize_access_request!, only: [:sign_out]
  before_action :authorize_refresh_by_access_request!, only: [:refresh]

  def sign_up
    valid_operation = false
    customer = Customer.new(customer_params)
    account = CheckingAccount.new(customer: customer)

    ActiveRecord::Base.transaction do
      valid_operation = customer.save && account.save
      raise ActiveRecord::Rollback unless valid_operation
    end

    if valid_operation
      tokens = generate_tokens(customer)
      render json: { access: tokens[:access] }, status: :created
    else
      errors = (customer.errors.full_messages + account.errors.full_messages).join(', ')
      render json: { error: errors }, status: :unprocessable_entity
    end
  end

  def sign_in
    customer = Customer.find_by!(cpf: params[:cpf])
    return not_authorized unless customer.authenticate(params[:password])

    tokens = generate_tokens(customer)
    render json: { access: tokens[:access] }
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Customer not found' }, status: :not_found
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

    render json: { access: tokens[:access] }
  end

  private

  def generate_tokens(customer)
    payload = { customer_id: customer.id }
    # By default access token is valid by 1 hour and refresh token by 1 week (github.com/tuwukee/jwt_sessions#expiration-time)
    session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
    session.login
  end

  def customer_params
    params.permit(:cpf, :password, :password_confirmation)
  end
end
