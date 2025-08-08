FactoryBot.define do
  factory :message do
    association :sender, factory: :user
    association :recipient, factory: :user
    content { "Hello world" }
  end
end
