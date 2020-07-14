class Customer < ApplicationRecord
  has_secure_password
  has_one :account, dependent: :destroy
  has_many :transactions, through: :account
  validates :cpf, presence: true
end
