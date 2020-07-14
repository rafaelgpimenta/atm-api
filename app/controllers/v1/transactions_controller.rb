class V1::TransactionsController < ApplicationController
  before_action :authorize_access_request!
  before_action :set_transaction, only: [:show, :update, :destroy]

  # GET /transactions
  def index
    # TODO: pagination
    @transactions = current_customer.transactions

    render json: @transactions
  end

  # GET /transactions/1
  def show
    render json: @transaction
  end

  # POST /transactions
  def create
    @transaction = current_customer.transactions.build(transaction_params)
    valid_operation = false
    ActiveRecord::Base.transaction do
      valid_operation = @transaction.save &&
        current_customer.account.update_balance_with_transaction(@transaction.id)

      raise ActiveRecord::Rollback unless valid_operation
    end

    if valid_operation
      render json: @transaction, status: :created
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_transaction
    @transaction = current_customer.transactions.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def transaction_params
    params.require(:transaction).permit(:kind, :amount)
  end
end
