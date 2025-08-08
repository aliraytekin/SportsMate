FactoryBot.define do
  factory :comment do
    association :user
    association :event
    content { "Nice game" }
  end
end
