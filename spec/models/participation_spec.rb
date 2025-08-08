require 'rails_helper'

RSpec.describe Participation, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:event) }
  end

  describe "enums" do
    it { should define_enum_for(:status).with_values(cancelled: -1, attending: 1) }
    it { should define_enum_for(:payment_status).with_values(refunded: -1, pending: 0, paid: 1) }
  end

  describe "callbacks" do
    it "creates a notification for each follower when user joins an event" do
      user = create(:user)
      follower1 = create(:user)
      follower2 = create(:user)

      # Stub followers to return our fake users
      allow(user).to receive(:followers).and_return([follower1, follower2])

      expect {
        create(:participation, user: user)
      }.to change { Notification.count }.by(2)

      last_two = Notification.order(created_at: :desc).limit(2)
      expect(last_two.map(&:recipient)).to match_array([follower1, follower2])
      expect(last_two.map(&:actor)).to all(eq(user))
      expect(last_two.map(&:action)).to all(eq("joined_event"))
    end
  end
end
