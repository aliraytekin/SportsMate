require 'rails_helper'

RSpec.describe EventPolicy do
  let(:creator)      { create(:user) }
  let(:participant)  { create(:user) }
  let(:sport)        { create(:sport) }
  let(:event)        { create(:event, user: creator, sport: sport) }

  describe "Scope" do
    it "returns all events" do
      scope = Pundit.policy_scope!(creator, Event)
      expect(scope).to include(event)
    end
  end

  describe "#show?" do
    it "allows anyone" do
      expect(EventPolicy.new(creator, event).show?).to be true
      expect(EventPolicy.new(participant, event).show?).to be true
    end
  end

  describe "#new? / #create?" do
    it "allows anyone" do
      expect(EventPolicy.new(creator, Event.new)).to have_attributes(new?: true, create?: true)
      expect(EventPolicy.new(participant, Event.new)).to have_attributes(new?: true, create?: true)
    end
  end

  describe "#edit? / #update? / #cancel?" do
    it "allows the owner" do
      policy = EventPolicy.new(creator, event)
      expect(policy.edit?).to be true
      expect(policy.update?).to be true
      expect(policy.cancel?).to be true
    end

    it "denies non-owner" do
      policy = EventPolicy.new(participant, event)
      expect(policy.edit?).to be false
      expect(policy.update?).to be false
      expect(policy.cancel?).to be false
    end
  end

  describe "#payment?" do
    context "when user is not the owner" do
      it "allows access" do
        expect(EventPolicy.new(participant, event).payment?).to be true
      end
    end

    context "when user is the owner" do
      it "allows if owner has a pending participation" do
        create(:participation, event: event, user: creator, payment_status: :pending)
        expect(EventPolicy.new(creator, event).payment?).to be true
      end

      it "denies if owner has no pending participation" do
        expect(EventPolicy.new(creator, event).payment?).to be false
      end
    end
  end

  describe "#confirmation?" do
    it "allows if user has a paid participation" do
      create(:participation, event: event, user: participant, payment_status: :paid)
      expect(EventPolicy.new(participant, event).confirmation?).to be true
    end

    it "allows the owner" do
      expect(EventPolicy.new(creator, event).confirmation?).to be true
    end

    it "denies otherwise" do
      expect(EventPolicy.new(participant, event).confirmation?).to be false
    end
  end

  describe "#calendar?" do
    it "allows non-owner who participates" do
      create(:participation, event: event, user: participant)
      expect(EventPolicy.new(participant, event).calendar?).to be true
    end

    it "denies owner" do
      expect(EventPolicy.new(creator, event).calendar?).to be false
    end

    it "denies non-participating non-owner" do
      expect(EventPolicy.new(participant, event).calendar?).to be false
    end
  end
end
