puts "Starting seeding ..."

User.destroy_all
Event.destroy_all
Sport.destroy_all

puts "Users and events destroyed"

users = []

15.times do
  users << User.create(
    email: Faker::Internet.email,
    password: 123456
  )
end
