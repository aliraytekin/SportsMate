puts "Starting seeding ..."

User.destroy_all
Event.destroy_all
Sport.destroy_all

puts "Users and events destroyed"

users = []

15.times do
  users << User.create!(
    email: Faker::Internet.email,
    password: 123456
  )
end

puts "Users created: #{users.count}"

EVENT_TITLES = [
  "Sunday Morning Football Match",
  "Pickup Basketball at Local Gym",
  "Beach Volleyball Meetup",
  "Rugby Training Session",
  "Weekend Baseball Practice",
  "Doubles Tennis Match",
  "Table Tennis Challenge Night",
  "Morning Swimming Training",
  "Indoor Bouldering Session",
  "Boxing Sparring Practice",
  "Kickboxing Cardio Workout",
  "Judo Throwing Practice",
  "Saturday Road Cycling Group Ride",
  "Morning 5K Run",
  "Sunrise Yoga in the Park",
  "Weekend Golf Practice Session",
  "Beginner Surfing Lesson"
]


SPORTS = ["Football", "Basketball", "Volleyball", "Rugby", "Baseball", "Tennis",
          "Table Tennis", "Swimming", "Rock climbing", "Boxing", "Kickboxing",
          "Judo", "Cycling", "Running", "Yoga", "Golf", "Surfing"]

sports = []

SPORTS.map do |sport|
  sports << Sport.create(
    name: sport
  )
end

puts "Sports created: #{sports.count}"

20.times do
  Event.create!(
    sport: sports.sample,
    user: users.sample,
    title: EVENT_TITLES.sample,
    description: Faker::Lorem.paragraph(sentence_count: 20),
    start_time: ,
    end_time: ,
    address: ,
    venue: Events::VENUES.sample,
    max_participants: rand(1..30),
    price_per_participant: ,
  )
end
