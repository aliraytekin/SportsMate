require 'rails_helper'

RSpec.describe UserSportInterest, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:sport) }
  end

  describe "validations" do
    subject { build(:user_sport_interest) }

    it { should validate_presence_of(:skill_level) }

    it "validates inclusion in SKILL_LEVELS" do
      expect(subject.class::SKILL_LEVELS).to include(subject.skill_level)
    end

    it "is invalid with an unknown skill level" do
      user_sport = build(:user_sport_interest, skill_level: "Master")
      expect(user_sport).not_to be_valid
      expect(user_sport.errors[:skill_level]).to include("is not included in the list")
    end
  end
end
