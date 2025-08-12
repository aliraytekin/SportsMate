require 'rails_helper'

RSpec.describe UsersController, type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  describe "GET users/:id" do
    context "when user signed in" do
      before { sign_in user }

      it "return 200 and renders the profile" do
        get user_path(other_user)

        expect(response).to have_http_status(:ok)
        expect(response.body).to include(other_user.first_name)
      end

      it "assigns a new sport interest" do
        get user_path(user)
      end
    end

    context "when user signed in" do
      it "redirects to login page" do
        get user_path(other_user)
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET /users/:id/chat" do
    context "when signed in" do
      before { sign_in user }

      it "returns 200 and lists messages in ascending order" do
        create(:message, sender: user, recipient: other_user, content: "Hi", created_at: 2.hours.ago)
        create(:message, sender: other_user, recipient: user, content: "Hello!", created_at: 1.hour.ago)
        create(:message, sender: user, recipient: other_user, content: "How are you?", created_at: 10.minutes.ago)

        get chat_user_path(other_user)

        expect(response).to have_http_status(:ok)
        html = response.body

        expect(html).to include("Hi")
        expect(html).to include("Hello!")
        expect(html).to include("How are you?")
      end
    end

    context "when not signed in" do
      it "redirects to login page" do
        get user_path(other_user)
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
