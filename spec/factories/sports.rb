FactoryBot.define do
  factory :sport do
    name { Sport::NAMES.sample }
  end
end
