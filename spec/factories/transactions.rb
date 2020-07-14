FactoryBot.define do
  factory :transaction do
    account
    amount { 40 }
    kind { :withdraw }
  end
end
