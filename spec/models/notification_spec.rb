require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe "associations" do
    it { should belong_to(:recipient).class_name("User") }
    it { should belong_to(:actor).class_name("User") }
    it { should belong_to(:event).optional }
  end

  describe "callbacks" do
    it "broadcasts badge updates after update" do
      notification = create(:notification)

      allow(notification).to receive(:broadcast_replace_to)

      notification.update(read: true)

      expect(notification).to have_received(:broadcast_replace_to).with(
        "notifications_user_#{notification.recipient.id}",
        target: "notifications_badge",
        partial: "notifications/badge",
        locals: {
          unread_count: notification.recipient.received_notifications.where(read: false).count
        }
      )
    end
  end
end
