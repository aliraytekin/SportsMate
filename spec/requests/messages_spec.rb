require 'rails_helper'

RSpec.describe "Messages", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  before do
    sign_in user
  end

  describe "POST /messages" do
    context "with valid params" do
      it "creates a new message and redirects to chat" do
        expect {
          post messages_path, params: {
            message: {
              content: "Hello there",
              recipient_id: other_user.id
            }
          }
        }.to change(Message, :count).by(1)

        expect(response).to redirect_to(chat_user_path(other_user))
      end
    end

    context "with invalid params" do
      it "renders users/chat with unprocessable_entity" do
        expect {
          post messages_path, params: {
            message: {
              content: "",
              recipient_id: other_user.id
            }
          }
        }.not_to change(Message, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("Chat")
      end
    end
  end
end
