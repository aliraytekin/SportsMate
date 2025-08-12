class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :content, presence: true

  after_create_commit do
    broadcast_append_to(
      "event_#{event_id}_comments",
      target: "comments",
      partial: "comments/comment",
      locals: { comment: self }
    )
  end
end
