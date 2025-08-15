require 'rails_helper'

RSpec.describe "Events", type: :request do
  let(:user) { create(:user) }
  let(:sport) { create(:sport) }
  let(:event) { create(:event, user: user, sport: sport) }
  let(:paid_event) { create(:event, user: user, sport: sport, free: false, price_per_participant: 10) }

  describe "GET /events" do
    it "lists events" do
      create_list(:event, 3)
      get events_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Filter by distance")
    end

    it "filters events" do
      create(:event, title: "Morning Tennis", city: "Paris", difficulty: "Beginner", start_time: 1.day.from_now)
      get events_path, params: { query: "tennis", location: "Paris", difficulty: "Beginner", date_range: "#{Date.today} to #{Date.today + 2}" }
      expect(response.body).to include("Morning Tennis")
    end

    it "filters by favorite sports when signed in" do
      sign_in user
      create(:user_sport_interest, user: user, sport: sport)
      create(:event, sport: sport, title: "Fav Sport Event")
      get events_path, params: { favorite_sports: [sport.id] }
      expect(response.body).to include("Fav Sport Event")
    end

    it "filters by location radius" do
      event_nearby = create(:event, latitude: 40.7128, longitude: -74.0060, title: "Nearby Event")
      allow(Event).to receive(:near).and_return(Event.where(id: event_nearby.id))

      get events_path, params: { latitude: 40.7128, longitude: -74.0060, radius: 10 }
      expect(response.body).to include("Nearby Event")
    end
  end

  describe "GET /events/:id" do
    it "shows event with placeholder image" do
      client = instance_double(Pexels::Client)
      allow(Pexels::Client).to receive(:new).and_return(client)
      allow(client).to receive_message_chain(:photos, :search).and_return([])

      get event_path(event)
      expect(response.body).to include("No+Image+Found").or include("Error+Loading+Image")
    end

    it "shows event with real image" do
      client = instance_double(Pexels::Client)
      allow(Pexels::Client).to receive(:new).and_return(client)
      allow(client).to receive_message_chain(:photos, :search).and_return([{ src: { large: "http://example.com/image.jpg" } }])

      get event_path(event)
      expect(response.body).to include("http://example.com/image.jpg")
    end
  end

  describe "GET /events/new" do
    it "redirects unauthenticated" do
      get new_event_path
      expect(response).to redirect_to(new_user_session_path)
    end

    it "renders for authenticated user" do
      sign_in user
      get new_event_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Free event?")
    end
  end

  describe "POST /events" do
    before { sign_in user }

    it "creates with valid params" do
      expect {
        post events_path, params: { event: attributes_for(:event, sport_id: sport.id) }
      }.to change(Event, :count).by(1)
      expect(response).to redirect_to(event_path(Event.last))
    end

    it "renders new on failure" do
      post events_path, params: { event: attributes_for(:event, title: "", sport_id: sport.id) }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "GET /events/:id/edit" do
    it "renders the edit form" do
      sign_in user
      get edit_event_path(event)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "PATCH /events/:id" do
    before { sign_in user }

    it "updates with valid params" do
      patch event_path(event), params: { event: { title: "Updated" } }
      expect(event.reload.title).to eq("Updated")
      expect(response).to redirect_to(event_path(event))
    end

    it "renders edit on failure" do
      patch event_path(event), params: { event: { title: "" } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "PATCH /events/:id/cancel_event" do
    it "cancels the event" do
      sign_in user
      patch cancel_event_event_path(event)
      expect(event.reload.status).to eq("cancelled")
      expect(response).to redirect_to(event_path(event))
    end
  end

  describe "GET /events/:id/payment" do
    it "shows payment page" do
      sign_in user
      get payment_event_path(paid_event)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /events/:id/success" do
    it "marks payment as complete" do
      sign_in user
      post success_event_path(paid_event)
      expect(response).to redirect_to(event_path(paid_event))
    end
  end

  describe "GET /events/:id/confirmation" do
    it "renders confirmation" do
      sign_in user
      get confirmation_event_path(event)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /events/:id/calendar" do
    it "returns calendar data" do
      sign_in user
      get calendar_event_path(event)
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to include("text/calendar").or include("text/plain")
    end
  end
end
