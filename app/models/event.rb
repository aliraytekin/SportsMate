class Event < ApplicationRecord
  VENUES = ["Park", "Gym", "Sports Hall / Indoor Court", "Football Field", "Tennis Court", "Swimming Pool",
            "Climbing Gym", "Martial Art Studio", "Beach", "Dance Studio", "Yoga Studio", "Nature", "Golf Course"]
  enum status: { draft: 0, confirmed: 1, cancelled: -1 }

  belongs_to :user
  belongs_to :sport
  has_many :participations, dependent: :destroy
  has_many :users, through: :participations
  has_many_attached :photos

  before_validation :full_address
  geocoded_by :full_address
  after_validation :geocode, if: :location_changed?

  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { minimum: 20 }
  validates :start_time, :end_time, presence: true
  validates :address, presence: true
  validates :max_participants, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :venue, presence: true, inclusion: { in: VENUES }

  validate :capitalize_title
  validate :end_time_after_start_time

  include PgSearch::Model
  pg_search_scope :search_by_title_and_description,
                  against: %i[title description],
                  associated_against: {
                    sport: %i[name],
                    user: %i[first_name last_name]
                  },
                  using: {
                    tsearch: { prefix: true }
                  }

  private

  def capitalize_title
    self.title = title.titleize
  end

  def end_time_after_start_time
    if end_time <= start_time && start_time.present?
      errors.add(:end_time, "must be after the start time")
    end
  end

  def full_address
    self.address = [street, city, country].compact.join(", ")
  end

  def location_changed?
    will_save_change_to_street? || will_save_change_to_city? || will_save_change_to_country?
  end
end
