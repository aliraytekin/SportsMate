class Sport < ApplicationRecord
  has_many :events
  has_many :user_sports_interests

  validates :name, presence: true
end
