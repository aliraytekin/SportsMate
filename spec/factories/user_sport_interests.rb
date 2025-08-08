FactoryBot.define do
  factory :user_sport_interest do
    association :user
    association :sport
    skill_level { UserSportInterest::SKILL_LEVELS.sample }
  end
end
