class Customer < ApplicationRecord
  has_secure_password
  has_one :account, dependent: :destroy
  validates :cpf, presence: true
end
