class UserSportInterest < ApplicationRecord
  belongs_to :user
  belongs_to :sport
end
