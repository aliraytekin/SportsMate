class Message < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :recipient, class_name: "User"

  validates :content, presence: true

  after_create_commit :notify_message_sent

  private

  def notify_message_sent
    Notification.create!(
      recipient: recipient,
      actor: sender,
      action: "message_sent"
    )
    broadcast_append_to(
      "chat_#{[sender_id, recipient_id].sort.join("_")}",
      partial: "messages/message",
      locals: { message: self, current_user_id: sender_id },
      target: "messages"
    )
    broadcast_replace_to(
      "notifications_user_#{recipient_id}",
      target: "notifications_badge",
      partial: "notifications/badge",
      locals: { unread_count: recipient.received_notifications.where(read: false).count }
    )
  end
end
