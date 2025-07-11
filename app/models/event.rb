class Event < ApplicationRecord
  VENUES = ["Park", "Gym", "Sports Hall / Indoor Court", "Football Field", "Tennis Court", "Swimming Pool",
            "Climbing Gym", "Martial Art Studio", "Beach", "Dance Studio", "Yoga Studio", "Nature"]
  enum status: { draft: 0, confirmed: 1, cancelled: -1 }

  belongs_to :user
  belongs_to :sport
  has_many :participants, dependent: :destroy
  has_many :users, through: :participants

  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { minimum: 20 }
  validates :start_time, :end_time, presence: true
  validates :address, presence: true
  validates :max_participants, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :price_per_participant, presence: true
  validates :venue, presence: true, inclusion: { in: VENUES }

  validate :capitalize_title
  validate :end_time_after_start_time

  private

  def capitalize_title
    self.title = title.titleize
  end

  def end_time_after_start_time
    errors.add(:end_time, "must be after the start time") if end_time <= start_time
  end
end
