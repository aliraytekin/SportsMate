FactoryBot.define do
  factory :event do
    title { "Ultimate Frisbee Match" }
    description { "A fun and competitive ultimate frisbee match for all levels." }
    start_time { 2.days.from_now }
    end_time { 2.days.from_now + 2.hours }
    address { "123 Main St, Warsaw, Poland" }
    street { "123 Main St" }
    city { "Warsaw" }
    country { "Poland" }
    max_participants { 10 }
    venue { Event::VENUES.sample }
    difficulty { Event::DIFFICULTY.sample }
    price_per_participant { 0 }
    free { true }
    status { :confirmed }

    association :user
    association :sport

    trait :paid do
      free { false }
      price_per_participant { 15 }
    end
  end
end
