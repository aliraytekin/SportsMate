require 'rails_helper'

RSpec.describe Sport, type: :model do
  describe "associations" do
    it { should have_many(:events) }
    it { should have_many(:user_sport_interests) }
  end

  describe "validations" do
    subject { build(:sport) }

    it { should validate_presence_of(:name) }
  end
end
