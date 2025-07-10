class Participant < ApplicationRecord
  enum status: { cancelled: -1, attending: 1 }
  enum payment_status: { refunded: -1, pending: 0, paid: 1 }

  belongs_to :event
  belongs_to :user
end
