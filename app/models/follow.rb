class Follow < ApplicationRecord
  belongs_to :followed, class_name: "User"
  belongs_to :follower, class_name: "User"

  validates :followed_id, uniqueness: { scope: :follower_id }
  validate :cannot_follow_self

  after_create_commit :notify_follow

  def notify_follow
    Notification.create!(
      recipient: followed,
      actor: follower,
      action: "followed_you"
    )
  end

  private

  def cannot_follow_self
    errors.add(:base, "You cannot follow yourself") if follower_id == followed_id
  end
end
