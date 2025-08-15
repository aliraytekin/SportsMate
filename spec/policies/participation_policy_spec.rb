# spec/policies/participation_policy_spec.rb
require 'rails_helper'

RSpec.describe ParticipationPolicy do
  let(:user)        { create(:user) }
  let(:other_user)  { create(:user) }
  let(:sport)       { create(:sport) }
  let(:event)       { create(:event, user: other_user, sport: sport) }
  let(:participation_owned)   { create(:participation, event: event, user: user) }
  let(:participation_foreign) { create(:participation, event: event, user: other_user) }

  describe "Scope" do
    it "returns only participations belonging to the user" do
      participation_owned
      participation_foreign

      scope = Pundit.policy_scope!(user, Participation)
      expect(scope).to include(participation_owned)
      expect(scope).not_to include(participation_foreign)
    end
  end

  describe "#new? / #create?" do
    it "allows anyone to create" do
      policy = ParticipationPolicy.new(user, Participation.new)
      expect(policy.new?).to be true
      expect(policy.create?).to be true
    end
  end

  describe "#update?" do
    it "allows the owner" do
      expect(ParticipationPolicy.new(user, participation_owned).update?).to be true
    end

    it "denies non-owner" do
      expect(ParticipationPolicy.new(user, participation_foreign).update?).to be false
    end
  end

  describe "#cancel_participation?" do
    it "allows the owner" do
      expect(ParticipationPolicy.new(user, participation_owned).cancel_participation?).to be true
    end

    it "denies non-owner" do
      expect(ParticipationPolicy.new(user, participation_foreign).cancel_participation?).to be false
    end
  end
end
