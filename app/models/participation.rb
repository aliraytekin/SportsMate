class Participation < ApplicationRecord
  enum status: { cancelled: -1, attending: 1 }
  enum payment_status: { refunded: -1, pending: 0, paid: 1 }

  belongs_to :event
  belongs_to :user

  after_create_commit :notify_event_joined

  def notify_event_joined
    user.followers.each do |follower|
      Notification.create!(
        recipient: follower,
        actor: user,
        event: event,
        action: "joined_event"
      )
    end
  end
end
