require 'rails_helper'

RSpec.describe "Messages", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  describe "POST messages" do
    before { sign_up user }

    let(:path) { message_path(message) }

    context "when signed in" do
      it "creates a message" do
        message = create(:message, sender: user, recipient: other_user, content: "Hello there")
        expect {
          post path
        }.to change(Message, :count).by(1)
      end
    end
  end
end
