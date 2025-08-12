require 'rails_helper'

RSpec.describe "Events" do
  let(:user) { create(:user) }
  let(:sport) { create(:sport) }
  let(:event) { create(:event, user: user, sport: sport) }

  describe "GET /events" do
    it "paginates" do
      create_list(:event, 3)
      get events_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Events")
    end

    it "filters by query, location, difficulty and date range" do
      create(:event, title: "Morning Tennis", description: "Beginners welcome", city: "Paris", difficulty: "Beginner", start_time: 1.day.from_now)
      get events_path, params: {
        query: "tennis",
        location: "Paris",
        difficulty: "Beginner",
        date_range: "#{Date.today} to #{Date.today + 2}"
      }
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Morning Tennis")
    end
  end

  describe "GET /events/:id" do
    it "shows the event and participants" do
      get event_path(event)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(event.title)
    end

    it "falls back to placeholder image when no photos present" do
      client = instance_double(Pexels::Client)
      allow(Pexels::Client).to receive(:new).and_return(client)
      allow(client).to receive_message_chain(:photos, :search).and_return([])

      get event_path(event)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("No+Image+Found").or include("Error+Loading+Image")
    end
  end

  describe "GET /events/new" do
    it "renders the form" do
      get new_event_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Game Time 🎉")
    end
  end
end
