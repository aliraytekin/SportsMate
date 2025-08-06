require 'pexels'

puts "Starting seeding ..."

Notification.destroy_all
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

SPORT_WITH_ICONS = {
  "Football" => "football.png",
  "Basketball" => "basketball.png",
  "Volleyball" => "volleyball.png",
  "Rugby" => "rugby.png",
  "Baseball" => "baseball.png",
  "Tennis" => "tennis.png",
  "Table Tennis" => "table-tennis.png",
  "Swimming" => "swimming.png",
  "Rock climbing" => "rock_climbing.png",
  "Boxing" => "boxing.png",
  "Kickboxing" => "kickboxing.png",
  "Judo" => "judo.png",
  "Cycling" => "cycling.png",
  "Running" => "running.png",
  "Yoga" => "yoga.png",
  "Golf" => "golf.png",
  "Surfing" => "surfing.png"
}

SPORT_WITH_ICONS.each do |name, icon|
  sport = Sport.find_by(name: name)
  sport.icon = icon
  sport.save!
end

SPORT_DETAILS = {
  "Football" => {
    venues: ["Football Field", "Park"],
    titles: ["Sunday Morning Football Match", "Evening Football at City Park", "Casual 5-a-side Football Game"],
    description: "Gather with fellow players for a dynamic football match. Teams will be split evenly on arrival and games played with two 30-minute halves. Expect warmups, rotating substitutes, and plenty of fun. Bring cleats and water."

  },
  "Basketball" => {
    venues: ["Gym", "Sports Hall / Indoor Court"],
    titles: ["Pickup Basketball at Local Gym", "3v3 Basketball Tournament Practice", "Evening Basketball Shootaround"],
    description: "Meet up for a friendly basketball session. We'll divide into small teams and play quick matches to keep things moving. Great for casual players looking to get a sweat on. All equipment provided."
  },
  "Volleyball" => {
    venues: ["Beach", "Sports Hall / Indoor Court"],
    titles: ["Beach Volleyball Meetup", "Indoor Volleyball Game Night", "Saturday Volleyball Practice"],
    description: "Come serve, set, and spike in this fun volleyball meetup. Depending on numbers, we'll rotate teams and keep games casual and inclusive. Beach sessions add a sunny vibes don't 2019t forget sunscreen!"

  },
  "Rugby" => {
    venues: ["Football Field", "Park"],
    titles: ["Rugby Training Session", "Friendly Touch Rugby Game", "Weekend Rugby Skills Workshop"],
    description: "Focus on technique, teamwork, and fun during this rugby session. We'll warm up, do some drills, and play friendly touch or contact games depending on group preference. No experience needed."

  },
  "Baseball" => {
    venues: ["Park", "Football Field"],
    titles: ["Weekend Baseball Practice", "Casual Baseball Game at Central Field", "Evening Baseball Batting Practice"],
    description: "Join a relaxed game of baseball or batting practice. We'll divide into teams if numbers allow or run fielding and batting drills. Bring your glove if you have one!"
  },
  "Tennis" => {
    venues: ["Tennis Court"],
    titles: ["Doubles Tennis Match", "Beginner Tennis Practice Session", "Saturday Morning Tennis Ladder"],
    description: "Whether you're a beginner or regular player, join for a social tennis session. We'll rotate partners in short matches or practice rallies depending on attendance. Rackets available on request."
  },
  "Table Tennis" => {
    venues: ["Sports Hall / Indoor Court"],
    titles: ["Table Tennis Challenge Night", "Casual Ping Pong Meetup", "Friday Night Table Tennis Doubles"],
    description: "Challenge others to friendly matches in this social table tennis event. Expect fast-paced games, lots of laughs, and skill-building opportunities. Great for all levels."

  },
  "Swimming" => {
    venues: ["Swimming Pool", "Beach"],
    titles: ["Morning Swimming Training", "Open Water Swim Group", "Saturday Lap Swimming Workout"],
    description: "Structured swim sessions for all levels. Choose between lane swimming, endurance sets, or relaxed open water swims. Lifeguard may be present depending on location. Bring goggles and a towel!"

  },
  "Rock climbing" => {
    venues: ["Climbing Gym", "Nature"],
    titles: ["Indoor Bouldering Session", "Outdoor Climbing Trip Preparation", "Friday Evening Climbing Meetup"],
    description: "Join fellow climbers for a session focused on technique, fun, and problem-solving. Indoors will be bouldering and top rope. Outdoors will depend on the route and weather. Gear can be rented."

  },
  "Boxing" => {
    venues: ["Martial Art Studio", "Gym"],
    titles: ["Boxing Sparring Practice", "Beginner Boxing Technique Class"],
    description: "A structured boxing session including warmups, pad drills, and optional light sparring. Gloves provided. Great for fitness and building confidence, no experience required."

  },
  "Kickboxing" => {
    venues: ["Martial Art Studio", "Gym"],
    titles: ["Kickboxing Cardio Workout", "Kickboxing Sparring Night"],
    description: "Join us for a high-intensity kickboxing session focusing on cardio, technique, and strength. Warmups and partner drills will be followed by guided combinations and optional sparring. All levels welcome."

  },
  "Judo" => {
    venues: ["Martial Art Studio"],
    titles: ["Judo Throwing Practice", "Judo Technique Improvement Session"],
    description: "Practice fundamental judo throws, grips, and breakfalls in a safe and controlled setting. Sessions include warmups, technique drills, and light randori (sparring) depending on your comfort level."

  },
  "Cycling" => {
    venues: ["Park", "Nature"],
    titles: ["Saturday Road Cycling Group Ride", "Evening City Cycling Meetup"],
    description: "Ride with fellow cyclists at a relaxed pace through scenic routes or urban areas. Helmets required. We’ll keep the group together and take regular water breaks. A great way to stay fit and social."

  },
  "Running" => {
    venues: ["Park", "Nature"],
    titles: ["Morning 5K Run", "Evening Trail Running Group"],
    description: "Lace up for a social group run at a conversational pace. Warmup and cooldown included. Whether you're a jogger or training for a race, come enjoy movement and motivation in nature."

  },
  "Yoga" => {
    venues: ["Yoga Studio", "Park"],
    titles: ["Sunrise Yoga in the Park", "Evening Relaxation Yoga Class"],
    description: "Join us for a guided yoga session focused on balance, flexibility, and calm. We'll flow through beginner-friendly poses and end with a relaxing meditation. Bring your mat and dress comfortably."

  },
  "Golf" => {
    venues: ["Golf Course", "Park"],
    titles: ["Weekend Golf Practice Session", "9-Hole Casual Golf Game"],
    description: "A casual golf meetup for players of all skill levels. We’ll play a few holes together or practice swings and putting. Bring your clubs if possible—rentals may be available at the venue."

  },
  "Surfing" => {
    venues: ["Beach"],
    titles: ["Beginner Surfing Lesson", "Morning Surfing at Main Beach"],
    description: "Catch waves with fellow surf enthusiasts. Beginners will get a short on-beach lesson before hitting the water. Boards can be rented at the beach. Wetsuits recommended if the water is cold."
  }
}

puts "Sports created: #{sports.count}"

puts "Testing Pexels API Key..."
raise "PEXELS_API_KEY not found!" unless ENV['PEXELS_API_KEY'].present?

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
                                  titles: EVENT_TITLES,
                                  description: "Join us for an exciting sports event filled with energy and fun!"
  })

  start_time = Faker::Time.forward(days: 30, period: :day)
  location = NEW_ADDRESSES.sample

  event = Event.new(
    sport: sport,
    user: users.sample,
    title: details[:titles].sample,
    description: details[:description],
    start_time: start_time,
    end_time: start_time + rand(1..4).hours,
    street: location[:street],
    city: location[:city],
    country: location[:country],
    address: [location[:street], location[:city], location[:country]].compact.join(", "),
    venue: details[:venues].sample,
    max_participants: rand(1..30),
    price_per_participant: 0,
    free: true,
    difficulty: Event::DIFFICULTY.sample
  )

  event_image = sport_images[random_sport_name].sample
  puts "Downloading image #{event_image}"
  file = URI.open(event_image)
  event.photos.attach(io: file, filename: "event_#{rand(1000)}.jpg", content_type: "image/jpg")

  event.save!
end

puts "Events created: #{Event.count}!"
