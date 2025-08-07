require 'rails_helper'

describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should_not allow_value("bad value").for(:email) }
    it { should allow_value("account@mail.com").for(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(6) }
    it { should allow_value(nil).for(:bio) }
  end

  describe "associations" do
    it { should have_many(:participations).dependent(:destroy) }
    it { should have_many(:events).through(:participations) }
    it { should have_many(:created_events).class_name("Event").with_foreign_key("user_id").dependent(:destroy) }
    it { should have_many(:user_sport_interests).dependent(:destroy) }
    it { should have_many(:sports).through(:user_sport_interests) }
    it { should have_many(:active_follows).class_name("Follow").with_foreign_key("follower_id").dependent(:destroy) }
    it { should have_many(:following).through(:active_follows).source(:followed) }
    it { should have_many(:passive_follows).class_name("Follow").with_foreign_key("followed_id").dependent(:destroy) }
    it { should have_many(:followers).through(:passive_follows).source(:follower) }
    it { should have_many(:received_notifications).class_name("Notification").with_foreign_key("recipient_id").dependent(:destroy) }
    it { should have_many(:sent_notifications).class_name("Notification").with_foreign_key("actor_id").dependent(:nullify) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:received_messages).class_name("Message").with_foreign_key("recipient_id").dependent(:destroy) }
    it { should have_many(:sent_messages).class_name("Message").with_foreign_key("sender_id").dependent(:destroy) }
    it { should have_one_attached(:avatar) }
  end
end
