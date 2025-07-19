class Sport < ApplicationRecord
NAMES = ["Football", "Tennis", "Basketball", "Running", "Volleyball", "Table Tennis", "Climbing"]

  has_many :events
  has_many :user_sports_interests

  validates :name, presence: true
end
