class Customer < ApplicationRecord
  has_secure_password
  has_one :account, dependent: :destroy
  has_many :transactions, through: :account
  validates_presence_of :cpf
  validates_uniqueness_of :cpf, case_sensitive: false
end
