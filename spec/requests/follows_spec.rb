require 'rails_helper'

RSpec.describe "Follows", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  describe "POST /users/:user_id/follows" do
    let(:path) { user_follows_path(other_user) }

    context "when signed in" do
      before { sign_in user }

      it "create a follow and redirects the current user" do
        expect {
          post path
        }.to change(Follow, :count).by(1)

        follow = Follow.last
        expect(follow.followed).to eq(other_user)
        expect(follow.follower).to eq(user)
        expect(response).to redirect_to(user_path(other_user))
      end

      it "does not refollow someone again without unfollowing first" do
        post path
        expect {
          post path
        }.to_not change(Follow, :count)
      end

      it "does not allow follow yourself" do
        expect {
          post user_follows_path(user)
        }.to_not change(Follow, :count)

        expect(response).to redirect_to(root_path)
      end
    end

    context "when not signed in" do
      it "redirects to landing page" do
        post path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "DELETE /follows/:id" do
    context "when signed in" do
      before { sign_in user }

      it "destroy the follow if current user is the follower" do
        follow = create(:follow, followed: other_user, follower: user)

        expect {
          delete follow_path(follow)
        }.to change(Follow, :count).by(-1)

        expect(response).to redirect_to(user_path(other_user))
      end

      it "does not destroy if current_user is not the follower" do
        stranger = create(:user)
        follow   = create(:follow, follower: stranger, followed: other_user)

        expect {
          delete follow_path(follow)
        }.not_to change(Follow, :count)

        expect(response).to redirect_to(user_path(other_user))
      end
    end

    context "when not signed in" do
      it "redirects to login" do
        follow = create(:follow, follower: user, followed: other_user)
        delete follow_path(follow)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
