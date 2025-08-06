class Notification < ApplicationRecord
  belongs_to :recipient, class_name: "User"
  belongs_to :actor, class_name: "User"
  belongs_to :event, optional: true

  # after_create_commit :broadcast_badge_updates
  after_update_commit :broadcast_badge_updates

  private

  def broadcast_badge_updates
    broadcast_replace_to(
      "notifications_user_#{recipient.id}",
      target: "notifications_badge",
      partial: "notifications/badge",
      locals: { unread_count: recipient.received_notifications.where(read: false).count }
    )
  end
end
