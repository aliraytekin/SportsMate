require 'rails_helper'

RSpec.describe "UserSportInterests", type: :request do
  let(:user) { create(:user) }
  let(:sport) { create(:sport) }
  let!(:user_sport_interest) { create(:user_sport_interest, user: user, sport: sport, skill_level: "Beginner") }

  before { sign_in user }

  describe "POST /user_sport_interests" do
    context "with valid params" do
      it "creates a new interest and redirects" do
        expect {
          post user_sport_interests_path, params: {
            user_sport_interest: { sport_id: sport.id, skill_level: "Intermediate" }
          }
        }.to change(UserSportInterest, :count).by(1)

        expect(response).to redirect_to(user_path(user))
        expect(flash[:notice]).to eq("Thanks for updating your interests!")
      end
    end
  end

  describe "PATCH /user_sport_interests/:id" do
    context "with valid params" do
      it "updates the interest" do
        patch user_sport_interest_path(user_sport_interest), params: {
          user_sport_interest: { skill_level: "Advanced" }
        }
        expect(user_sport_interest.reload.skill_level).to eq("Advanced")
        expect(response).to redirect_to(user_path(user))
        expect(flash[:notice]).to eq("Your interests have been updated.")
      end
    end

    context "with invalid params" do
      it "does not update and shows alert" do
        patch user_sport_interest_path(user_sport_interest), params: {
          user_sport_interest: { sport_id: nil }
        }
        expect(response).to redirect_to(user_path(user))
        expect(flash[:alert]).to eq("Failed to update")
      end
    end
  end

  describe "DELETE /user_sport_interests/:id" do
    it "deletes the interest" do
      expect {
        delete user_sport_interest_path(user_sport_interest)
      }.to change(UserSportInterest, :count).by(-1)

      expect(response).to redirect_to(user_path(user))
      expect(flash[:notice]).to eq('Sport interest was successfully deleted.')
    end
  end
end
