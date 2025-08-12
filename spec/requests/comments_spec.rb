require 'rails_helper'

RSpec.describe CommentsController, type: :request do
  let(:user) { create(:user) }
  let(:event) { create(:event) }
  let(:path) { event_comments_path(event) }

  describe "POST events/show/:id" do
    context "when signed in" do
      before { sign_in user }

      it "creates a comment" do
        expect {
          post path, params: { comment: { content: "Hello guys!" } }
        }.to change(Comment, :count).by(1)

        expect(response).to redirect_to(event)
        comment = Comment.last
        expect(comment.user).to eq(user)
        expect(comment.content).to eq("Hello guys!")
        expect(comment.event).to eq(event)
      end
    end

    context "when not signed in" do
      it "redirects to the login page" do
        post path, params: { comment: { content: "Hello" } }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
