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
  "Evening Football at City Park",
  "Casual 5-a-side Football Game",
  "Pickup Basketball at Local Gym",
  "3v3 Basketball Tournament Practice",
  "Evening Basketball Shootaround",
  "Beach Volleyball Meetup",
  "Indoor Volleyball Game Night",
  "Saturday Volleyball Practice",
  "Rugby Training Session",
  "Friendly Touch Rugby Game",
  "Weekend Rugby Skills Workshop",
  "Weekend Baseball Practice",
  "Casual Baseball Game at Central Field",
  "Evening Baseball Batting Practice",
  "Doubles Tennis Match",
  "Beginner Tennis Practice Session",
  "Saturday Morning Tennis Ladder",
  "Table Tennis Challenge Night",
  "Casual Ping Pong Meetup",
  "Friday Night Table Tennis Doubles",
  "Morning Swimming Training",
  "Open Water Swim Group",
  "Saturday Lap Swimming Workout",
  "Indoor Bouldering Session",
  "Outdoor Climbing Trip Preparation",
  "Friday Evening Climbing Meetup",
  "Boxing Sparring Practice",
  "Beginner Boxing Technique Class",
  "Kickboxing Cardio Workout",
  "Kickboxing Sparring Night",
  "Judo Throwing Practice",
  "Judo Technique Improvement Session",
  "Saturday Road Cycling Group Ride",
  "Evening City Cycling Meetup",
  "Morning 5K Run",
  "Evening Trail Running Group",
  "Sunrise Yoga in the Park",
  "Evening Relaxation Yoga Class",
  "Weekend Golf Practice Session",
  "9-Hole Casual Golf Game",
  "Beginner Surfing Lesson",
  "Morning Surfing at Main Beach"
]

ADDRESSES = [
  "Central Park, New York, NY, USA",
  "Hyde Park, London, UK",
  "Marina Bay Sands, Singapore",
  "Bondi Beach, Sydney, Australia",
  "Copacabana Beach, Rio de Janeiro, Brazil",
  "Shinjuku Gyoen, Tokyo, Japan",
  "Times Square, New York, NY, USA",
  "Champs-Élysées, Paris, France",
  "La Rambla, Barcelona, Spain",
  "Oxford Street, London, UK",
  "Piazza San Marco, Venice, Italy",
  "Alexanderplatz, Berlin, Germany",
  "Dam Square, Amsterdam, Netherlands",
  "Gran Via, Madrid, Spain",
  "Union Square, San Francisco, CA, USA",
  "Hollywood Boulevard, Los Angeles, CA, USA",
  "Nathan Road, Hong Kong",
  "Ginza, Tokyo, Japan",
  "Orchard Road, Singapore",
  "Istiklal Avenue, Istanbul, Turkey",
  "Khaosan Road, Bangkok, Thailand",
  "Pitt Street, Sydney, Australia",
  "Kurfürstendamm, Berlin, Germany",
  "Fifth Avenue, New York, NY, USA",
  "Nanjing Road, Shanghai, China",
  "Myeongdong, Seoul, South Korea",
  "Bukit Bintang, Kuala Lumpur, Malaysia",
  "Petaling Street, Kuala Lumpur, Malaysia",
  "Plaza Mayor, Madrid, Spain",
  "Plaza de Armas, Lima, Peru",
  "Syntagma Square, Athens, Greece",
  "Piazza del Popolo, Rome, Italy",
  "Via del Corso, Rome, Italy",
  "Princes Street, Edinburgh, Scotland",
  "Karl Johans gate, Oslo, Norway",
  "Nevsky Prospect, St Petersburg, Russia",
  "Zaryadye Park, Moscow, Russia",
  "Old Town Square, Prague, Czech Republic",
  "Market Street, San Francisco, CA, USA"
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

25.times do
  Event.create!(
    sport: sports.sample,
    user: users.sample,
    title: EVENT_TITLES.sample,
    description: Faker::Lorem.paragraph(sentence_count: 20),
    start_time: start_time = Faker::Time.forward(days: 30, period: :day),
    end_time: start_time + rand(1..4).hours,
    address: ADDRESSES.sample,
    venue: Event::VENUES.sample,
    max_participants: rand(1..30),
    price_per_participant: 0,
    free: true
  )
end

puts "Events created: #{Event.count}!"
