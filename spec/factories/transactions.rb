FactoryBot.define do
  factory :transaction do
    amount { "9.99" }
    account { nil }
    type { 1 }
  end
end
