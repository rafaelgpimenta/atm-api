class Transaction < ApplicationRecord
  belongs_to :account

  validates_presence_of :amount, :kind
  validates_numericality_of :amount, greater_than: 0
  validate :correct_amount, on: :create, if: :withdraw?

  before_save :save_withdraw_details, if: :withdraw?
  enum kind: { withdraw: 0, deposit: 1 }

  VALID_VALUES = [100, 50, 20, 10]

  private

  def correct_amount
    return if VALID_VALUES.any? { |value| amount % value == 0 }

    errors.add(:amount, "Cannot withdraw the requested value")
  end

  def save_withdraw_details
    total = amount
    paper_money = {}
    VALID_VALUES.each do |value|
      count = total.div(value)
      next if count == 0

      total -= count * value
      paper_money[value] = count
    end

    self.details = { printed_value: paper_money }
  end
end
