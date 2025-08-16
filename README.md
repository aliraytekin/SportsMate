[![View detailed test coverage on Codecov](https://codecov.io/gh/aliraytekin/SportsMate/branch/master/graph/badge.svg?token=JSSO7HNNXT)](https://codecov.io/gh/aliraytekin/SportsMate)

# 🏀 Sportsmate

**Sportsmate** is a social platform built with Ruby on Rails where people can **create, join, and manage sports events** in their area. It’s designed to make it easier for athletes and hobbyists to connect, organize games, and stay engaged with their sports communities.

---

## ✨ Features

- 🔐 **Authentication** via [Devise](https://github.com/heartcombo/devise) (Google OAuth2 support included)  
- 📅 **Events**: create, join, filter (by sport, location, difficulty, date range)  
- 🖼️ **Dynamic images** for events using [Pexels API](https://www.pexels.com/api/) (with graceful fallbacks)  
- 💬 **Real-time messaging** between users (Turbo Streams)  
- 🔔 **Notifications system** for event updates & user activity  
- 💳 **Stripe test payments** for event booking (in progress)  
- 🌍 **Interactive maps** powered by [Mapbox](https://www.mapbox.com/)  
- 📱 Fully responsive UI  

---

## 🛠️ Tech Stack

**Backend**
- [Ruby on Rails 7](https://rubyonrails.org/)
- [PostgreSQL](https://www.postgresql.org/) for database
- [Redis](https://redis.io/) for background jobs (planned)

**Frontend**
- [Hotwire (Turbo + Stimulus)](https://hotwired.dev/)
- [Bootstrap 5](https://getbootstrap.com/)
- JavaScript (with [Matter.js](https://brm.io/matter-js/) for fun animations)

**Testing**
- [RSpec](https://rspec.info/) for unit & request specs
- [FactoryBot](https://github.com/thoughtbot/factory_bot) for test data
- [SimpleCov](https://github.com/simplecov-ruby/simplecov) for coverage

**CI/CD**
- [GitHub Actions](https://docs.github.com/en/actions) for continuous integration
- [Codecov](https://about.codecov.io/) for test coverage reporting
