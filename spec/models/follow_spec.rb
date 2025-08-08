require 'rails_helper'

RSpec.describe Follow, type: :model do
  describe "associations" do
    it { should belong_to(:follower).class_name("User") }
    it { should belong_to(:followed).class_name("User") }
  end

  describe "validations" do
    subject { create(:follow) }  # one valid follow needed for uniqueness matcher to work

    it { should validate_uniqueness_of(:followed_id).scoped_to(:follower_id) }

    it "does not allow a user to follow themselves" do
      user = create(:user)
      follow = Follow.new(follower: user, followed: user)
      follow.valid?
      expect(follow.errors[:base]).to include("You cannot follow yourself")
    end
  end

  describe "callbacks" do
    it "creates a notification after follow" do
      follower = create(:user)
      followed = create(:user)

      expect {
        create(:follow, follower: follower, followed: followed)
      }.to change { Notification.count }.by(1)

      notification = Notification.last
      expect(notification.recipient).to eq(followed)
      expect(notification.actor).to eq(follower)
      expect(notification.action).to eq("followed_you")
    end
  end
end
