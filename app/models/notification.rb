class Notification < ApplicationRecord
  belongs_to :recipient, class_name: "User"
  belongs_to :actor, class_name: "User"
  belongs_to :event, optional: true

  broadcasts_to ->(notification) { "notifications_user_#{notification.recipient_id}" }, inserts_by: :prepend
end
