FactoryBot.define do
  factory :account do
    customer { nil }
    type { 1 }
    balance { "9.99" }
  end
end
