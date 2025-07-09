class Event < ApplicationRecord
  belongs_to :user
  belongs_to :sport
  has_many :participants
  has_many :users, through: :participants
end
