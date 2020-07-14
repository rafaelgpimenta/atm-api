FactoryBot.define do
  factory :account do
    customer
    checking
    balance { 0.0 }

    trait :checking do
      type { "CheckingAccount" }
    end

    trait :saving do
      type { "SavingAccount" }
    end
  end
end
