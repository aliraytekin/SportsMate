class Event < ApplicationRecord
  VENUES = ["Park", "Gym", "Sports Hall / Indoor Court", "Football Field", "Tennis Court", "Swimming Pool",
            "Climbing Gym", "Martial Art Studio", "Beach", "Dance Studio", "Yoga Studio", "Nature", "Golf Course"]
  enum status: { draft: 0, confirmed: 1, cancelled: -1 }
  DIFFICULTY = ["Beginner", "Intermediate", "Advanced"]

  belongs_to :user
  belongs_to :sport
  has_many :participations, dependent: :destroy
  has_many :users, through: :participations
  has_many :comments, dependent: :destroy
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
  validates :price_per_participant, numericality: { greater_than_or_equal_to: 0 }
  validates :difficulty, presence: true, inclusion: { in: DIFFICULTY }

  validate :capitalize_title
  validate :end_time_after_start_time
  before_validation :free_then_price_is_zero
  validate :free_and_price_consistency

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

  after_create_commit :notify_event_creation

  def notify_event_creation
    user.followers.each do |follower|
      Notification.create!(
        recipient: follower,
        actor: user,
        event: self,
        action: "joined_event"
      )
    end
  end

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

  def free_and_price_consistency
    if free && price_per_participant.to_i > 0
      errors.add(:base, "Price cannot be higher than 0 if event is free")
    elsif !free && price_per_participant.to_i <= 0
      errors.add(:base, "Price must be higher than 0 unless event is free")
    end
  end

  def free_then_price_is_zero
      self.price_per_participant = 0 if free
  end
end
