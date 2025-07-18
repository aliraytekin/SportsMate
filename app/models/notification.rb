class Notification < ApplicationRecord
  belongs_to :recipient, class_name: "User"
  belongs_to :actor, class_name: "User"
  belongs_to :event, optional: true

  after_create_commit :broadcast_message

  def broadcast_message
    broadcasts_to ->(notification) { "notifications_user_#{notification.recipient_id}" }, inserts_by: :prepend
  end
end
