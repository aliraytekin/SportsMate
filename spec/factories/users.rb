FactoryBot.define do
  factory :user do
    first_name { "User" }
    last_name { "Last" }
    email { Faker::Internet.unique.email }
    password { "password" }
  end
end
