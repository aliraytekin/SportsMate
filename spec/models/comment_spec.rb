require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:event) }
  end

  describe "callback" do
    it "broadcast comment after comment creation" do
      comment = build(:comment)

      allow(comment).to receive(:broadcast_append_to)

      comment.save

      expect(comment).to have_received(:broadcast_append_to).with(
        "event_#{comment.event_id}_comments",
        target: "comments",
        partial: "comments/comment",
        locals: { comment: comment }
      )
    end
  end
end
