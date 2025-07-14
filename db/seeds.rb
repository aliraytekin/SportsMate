require 'pexels'

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
  "Central Park, New York, USA",
  "Hyde Park, London, UK",
  "Marina Bay Sands, Singapore",
  "Bondi Beach, Sydney, Australia",
  "Copacabana Beach, Rio de Janeiro, Brazil",
  "Shinjuku Gyoen, Tokyo, Japan",
  "Champs-Élysées, Paris, France",
  "La Rambla, Barcelona, Spain",
  "Oxford Street, London, UK",
  "Piazza San Marco, Venice, Italy",
  "Alexanderplatz, Berlin, Germany",
  "Dam Square, Amsterdam, Netherlands",
  "Gran Via, Madrid, Spain",
  "Union Square, San Francisco, USA",
  "Hollywood Boulevard, Los Angeles, USA",
  "Nathan Road, Hong Kong, Hong Kong",
  "Ginza, Tokyo, Japan",
  "Orchard Road, Singapore, Singapore",
  "Istiklal Avenue, Istanbul, Turkey",
  "Khaosan Road, Bangkok, Thailand",
  "Pitt Street, Sydney, Australia",
  "Kurfürstendamm, Berlin, Germany",
  "Fifth Avenue, New York, USA",
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
  "Market Street, San Francisco, USA"
]

NEW_ADDRESSES = ADDRESSES.map do |address|
  parts = address.split(", ")

  { street: parts[0], city: parts[1], country: parts[2] }
end

SPORTS = ["Football", "Basketball", "Volleyball", "Rugby", "Baseball", "Tennis",
          "Table Tennis", "Swimming", "Rock climbing", "Boxing", "Kickboxing",
          "Judo", "Cycling", "Running", "Yoga", "Golf", "Surfing"]

sports = []

SPORTS.map do |sport|
  sports << Sport.create(
    name: sport
  )
end

SPORT_DETAILS = {
  "Football" => {
    venues: ["Football Field", "Park"],
    titles: ["Sunday Morning Football Match", "Evening Football at City Park", "Casual 5-a-side Football Game"]
  },
  "Basketball" => {
    venues: ["Gym", "Sports Hall / Indoor Court"],
    titles: ["Pickup Basketball at Local Gym", "3v3 Basketball Tournament Practice", "Evening Basketball Shootaround"]
  },
  "Volleyball" => {
    venues: ["Beach", "Sports Hall / Indoor Court"],
    titles: ["Beach Volleyball Meetup", "Indoor Volleyball Game Night", "Saturday Volleyball Practice"]
  },
  "Rugby" => {
    venues: ["Football Field", "Park"],
    titles: ["Rugby Training Session", "Friendly Touch Rugby Game", "Weekend Rugby Skills Workshop"]
  },
  "Baseball" => {
    venues: ["Park", "Football Field"],
    titles: ["Weekend Baseball Practice", "Casual Baseball Game at Central Field", "Evening Baseball Batting Practice"]
  },
  "Tennis" => {
    venues: ["Tennis Court"],
    titles: ["Doubles Tennis Match", "Beginner Tennis Practice Session", "Saturday Morning Tennis Ladder"]
  },
  "Table Tennis" => {
    venues: ["Sports Hall / Indoor Court"],
    titles: ["Table Tennis Challenge Night", "Casual Ping Pong Meetup", "Friday Night Table Tennis Doubles"]
  },
  "Swimming" => {
    venues: ["Swimming Pool", "Beach"],
    titles: ["Morning Swimming Training", "Open Water Swim Group", "Saturday Lap Swimming Workout"]
  },
  "Rock climbing" => {
    venues: ["Climbing Gym", "Nature"],
    titles: ["Indoor Bouldering Session", "Outdoor Climbing Trip Preparation", "Friday Evening Climbing Meetup"]
  },
  "Boxing" => {
    venues: ["Martial Art Studio", "Gym"],
    titles: ["Boxing Sparring Practice", "Beginner Boxing Technique Class"]
  },
  "Kickboxing" => {
    venues: ["Martial Art Studio", "Gym"],
    titles: ["Kickboxing Cardio Workout", "Kickboxing Sparring Night"]
  },
  "Judo" => {
    venues: ["Martial Art Studio"],
    titles: ["Judo Throwing Practice", "Judo Technique Improvement Session"]
  },
  "Cycling" => {
    venues: ["Park", "Nature"],
    titles: ["Saturday Road Cycling Group Ride", "Evening City Cycling Meetup"]
  },
  "Running" => {
    venues: ["Park", "Nature"],
    titles: ["Morning 5K Run", "Evening Trail Running Group"]
  },
  "Yoga" => {
    venues: ["Yoga Studio", "Park"],
    titles: ["Sunrise Yoga in the Park", "Evening Relaxation Yoga Class"]
  },
  "Golf" => {
    venues: ["Golf Course", "Park"],
    titles: ["Weekend Golf Practice Session", "9-Hole Casual Golf Game"]
  },
  "Surfing" => {
    venues: ["Beach"],
    titles: ["Beginner Surfing Lesson", "Morning Surfing at Main Beach"]
  }
}

puts "Sports created: #{sports.count}"

client = Pexels::Client.new(ENV['PEXELS_API_KEY'])

sport_images = {}

SPORTS.each do |sport|
  photos = client.photos.search(sport, per_page: 5)
  images_url = photos.map { |photo| photo.src["original"] }
  sport_images[sport] = images_url
end

25.times do
  sport = sports.sample
  random_sport_name = sport.name
  details = SPORT_DETAILS.fetch(random_sport_name, {
                                  venues: Event::VENUES,
                                  titles: EVENT_TITLES
  })

  start_time = Faker::Time.forward(days: 30, period: :day)
  location = NEW_ADDRESSES.sample

  event = Event.new(
    sport: sport,
    user: users.sample,
    title: details[:titles].sample,
    description: Faker::Lorem.paragraph(sentence_count: 20),
    start_time: start_time,
    end_time: start_time + rand(1..4).hours,
    street: location[:street],
    city: location[:city],
    country: location[:country],
    address: [location[:street], location[:city], location[:country]].compact.join(", "),
    venue: details[:venues].sample,
    max_participants: rand(1..30),
    price_per_participant: 0,
    free: true
  )

  2.times do
    event_image = sport_images[random_sport_name].sample
    puts "Downloading image #{event_image}"
    file = URI.open(event_image)
    event.photos.attach(io: file, filename: "event_#{rand(1000)}.jpg", content_type: "image/jpg")
  end

  event.save!
end

puts "Events created: #{Event.count}!"
