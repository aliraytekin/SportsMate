class UserSportInterest < ApplicationRecord
  SKILL_LEVELS = ["Beginner", "Intermediate", "Advanced"]

  belongs_to :user
  belongs_to :sport

  validates :skill_level, presence: true, inclusion: { in: SKILL_LEVELS }
end
