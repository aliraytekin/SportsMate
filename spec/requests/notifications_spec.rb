require "rails_helper"

RSpec.describe "Notifications", type: :request do
  let(:user)      { create(:user) }
  let(:other)     { create(:user) }
  let(:path)      { mark_as_read_notifications_path }

  before { sign_in user }

  describe "POST /notifications/mark_as_read" do
    context "turbo_stream" do
      it "marks only current user's unread notifications as read and returns turbo stream" do
        n1 = create(:notification, recipient: user, read: false)
        n2 = create(:notification, recipient: user, read: false)
        _n3 = create(:notification, recipient: user, read: true)

        n_other = create(:notification, recipient: other, read: false)

        expect {
          post path, headers: { "Accept" => "text/vnd.turbo-stream.html" }
        }.to change { user.received_notifications.where(read: false).count }.from(2).to(0)

        expect(n_other.reload.read).to be(false)

        expect(response).to have_http_status(:ok)
        expect(response.media_type).to eq("text/vnd.turbo-stream.html")
        expect(response.body).to include("<turbo-stream")
      end
    end

    context "html" do
      it "marks unread as read and returns 200 OK" do
        create_list(:notification, 2, recipient: user, read: false)

        post path

        expect(response).to have_http_status(:ok)
        expect(user.received_notifications.where(read: false).count).to eq(0)
      end
    end

    context "when there are no unread notifications" do
      it "returns turbo stream with zero count" do
        create(:notification, recipient: user, read: true)

        post path, headers: { "Accept" => "text/vnd.turbo-stream.html" }

        expect(response).to have_http_status(:ok)
        expect(response.body).to include("notifications_badge")
      end
    end
  end

  context "when not signed in" do
    before { sign_out user }

    it "redirects to login" do
      post path
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
