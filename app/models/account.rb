class Account < ApplicationRecord
  belongs_to :customer
  has_many :transactions, dependent: :destroy

  def update_balance_with_transaction(transaction_id)
    transaction = transactions.find(transaction_id)
    if transaction.withdraw?
      update(balance: balance - transaction.amount)
    else
      update(balance: balance + transaction.amount)
    end
  end
end
