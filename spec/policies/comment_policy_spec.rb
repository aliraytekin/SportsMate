require 'rails_helper'

RSpec.describe CommentPolicy do
  let(:user) { create(:user) }
  let(:event) { create(:event) }
  let(:comment) { create(:comment, user: user, event: event) }

  subject { described_class }

  describe "create?" do
    it "anyone can create a comment" do
      policy = CommentPolicy.new(user, comment)
      expect(policy.create?).to be true
    end
  end
end
