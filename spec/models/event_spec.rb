require 'rails_helper'

RSpec.describe Event, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:sport) }
    it { should have_many(:participations).dependent(:destroy) }
    it { should have_many(:users).through(:participations) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many_attached(:photos) }
  end

  describe "validations" do
    subject { build(:event) }

    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(100) }

    it { should validate_presence_of(:description) }
    it { should validate_length_of(:description).is_at_least(20) }

    it { should validate_presence_of(:start_time) }
    it { should validate_presence_of(:end_time) }

    it "sets address from street, city and country" do
      event = build(:event, street: "Main Boulevard", city: "Paris", country: "France")
      event.valid?
      expect(event.address).to eq("Main Boulevard, Paris, France")
    end

    it { should validate_presence_of(:max_participants) }

    it { should validate_presence_of(:venue) }
    it { should validate_inclusion_of(:venue).in_array(Event::VENUES) }

    it { should validate_presence_of(:difficulty) }
    it { should validate_inclusion_of(:difficulty).in_array(Event::DIFFICULTY) }
  end

  describe "enums" do
    it { should define_enum_for(:status).with_values(draft: 0, confirmed: 1, cancelled: -1) }
  end

  describe "custom validations" do
    it "capitalizes the title" do
      event = build(:event, title: "my custom title")
      event.valid?
      expect(event.title).to eq("My Custom Title")
    end

    it "adds an error if end_time is before start_time" do
      event = build(:event, start_time: Time.now + 3.hours, end_time: Time.now + 2.hours)
      event.valid?
      expect(event.errors[:end_time]).to include("must be after the start time")
    end

    it "adds error if event is not free and price <= 0" do
      event = build(:event, free: false, price_per_participant: 0)
      event.valid?
      expect(event.errors[:base]).to include("Price must be higher than 0 unless event is free")
    end

    it "sets price_per_participant to 0 when free is true" do
      event = build(:event, free: true, price_per_participant: 100)
      event.valid?
      expect(event.price_per_participant).to eq(0)
    end
  end

  describe "callbacks" do
    it "creates notifications for followers after creation" do
      creator = create(:user)
      follower1 = create(:user)
      follower2 = create(:user)
      allow(creator).to receive(:followers).and_return([follower1, follower2])

      expect {
        create(:event, user: creator)
      }.to change { Notification.count }.by(2)
    end
  end
end
