require 'rails_helper'

describe Message, type: :model do
  describe "associations" do
    it { should belong_to(:sender).class_name("User") }
    it { should belong_to(:recipient).class_name("User") }
  end

  describe "validations" do
    it { should validate_presence_of(:content) }
  end

  describe "callback" do
    it "calls notify_message_sent after create" do
      message = build(:message)
      expect(message).to receive(:notify_message_sent)
      message.save
    end
  end

  describe "notification creation" do
    it "creates a notification after message creation" do
      sender = create(:user)
      recipient = create(:user)
      expect {
        create(:message, sender: sender, recipient: recipient, content: "Hello world")
      }.to change { Notification.count }.by(1)
    end
  end
end
