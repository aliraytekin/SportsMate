FactoryBot.define do
  factory :participation do
    association :user
    association :event
    status { :attending }
    payment_status { :paid }
  end
end
