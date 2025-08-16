require 'rails_helper'

RSpec.describe Users::OmniauthCallbacksController, type: :request do
  before do
    OmniAuth.config.test_mode = true
  end

  let(:google_auth_hash) do
    OmniAuth::AuthHash.new(
      provider: 'google_oauth2',
      uid: '123456789',
      info: {
        email: 'test@example.com',
        first_name: 'Test',
        last_name: 'User'
      }
    )
  end

  describe "GET /users/auth/google_oauth2/callback" do
    context "when user is new" do
      it "creates a new user and signs them in" do
        OmniAuth.config.mock_auth[:google_oauth2] = google_auth_hash
        allow(User).to receive(:from_omniauth).and_return(build(:user, email: 'test@example.com'))

        expect {
          get user_google_oauth2_omniauth_callback_path
        }.to change(User, :count).by(1)

        follow_redirect!

        expect(response.body).to include("Discover events")
        expect(controller.current_user.email).to eq('test@example.com')
      end
    end

    context "when user already exists" do
      let!(:existing_user) { create(:user, email: 'test@example.com') }

      it "signs in the existing user" do
        OmniAuth.config.mock_auth[:google_oauth2] = google_auth_hash
        allow(User).to receive(:from_omniauth).and_return(existing_user)

        expect {
          get user_google_oauth2_omniauth_callback_path
        }.not_to change(User, :count)

        expect(controller.current_user).to eq(existing_user)
      end
    end
  end
end
