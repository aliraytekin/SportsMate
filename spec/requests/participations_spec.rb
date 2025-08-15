# spec/requests/participations_spec.rb
require 'rails_helper'

RSpec.describe "Participations", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:sport) { create(:sport) }
  let(:free_event) { create(:event, user: other_user, sport: sport, price_per_participant: 0, max_participants: 5) }
  let(:paid_event) { create(:event, user: other_user, sport: sport, price_per_participant: 10, free: false, max_participants: 5) }

  before { sign_in user }

  describe "GET /participations" do
    it "returns http success" do
      get participations_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /events/:event_id/participations" do
    context "joining a free event" do
      it "creates participation and sends confirmation" do
        expect {
          post event_participations_path(free_event)
        }.to change(Participation, :count).by(1)

        participation = Participation.last
        expect(participation.status).to eq("attending")
        expect(response).to redirect_to(event_path(free_event))
      end
    end

    context "joining a paid event" do
      it "creates participation with pending payment" do
        post event_participations_path(paid_event)
        participation = Participation.last
        expect(participation.payment_status).to eq("pending")
        expect(response).to redirect_to(payment_event_path(paid_event))
      end
    end

    context "when already joined" do
      it "does not create participation" do
        create(:participation, event: free_event, user: user)
        expect {
          post event_participations_path(free_event)
        }.not_to change(Participation, :count)
        expect(flash[:alert]).to eq("You're already in this event.")
      end
    end

    context "when event is full" do
      it "does not create participation" do
        free_event.update!(max_participants: 1)
        create(:participation, event: free_event, user: other_user)
        post event_participations_path(free_event)
        expect(flash[:alert]).to eq("This event is full.")
      end
    end

    context "when joining own event" do
      it "does not create participation" do
        own_event = create(:event, user: user, sport: sport)
        post event_participations_path(own_event)
        expect(flash[:alert]).to eq("You cannot join your own event.")
      end
    end
  end

  describe "PATCH /participations/:id/cancel_participation" do
    it "cancels the participation" do
      participation = create(:participation, event: free_event, user: user)
      patch cancel_participation_participation_path(participation)
      expect(participation.reload.status).to eq("cancelled")
      expect(response).to redirect_to(participations_path)
    end
  end
end
