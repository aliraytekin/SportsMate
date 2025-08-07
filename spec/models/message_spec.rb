require 'rails_helper'

describe Message, type: :model do
  describe "associations" do
    it { should belongs_to(:sender).class_name("User") }
    it { should belongs_to(:recipient).class_name("User") }
  end

  describe "validations" do
    it { should validate_presence_of(:content) }
  end
end
