FactoryBot.define do
  factory :notification do
    association :recipient, factory: :user
    association :actor, factory: :user
    action { "joined_event" }
    read { false }
  end
end
