class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :participations, dependent: :destroy
  has_many :events, through: :participations
  has_many :created_events, class_name: "Event", foreign_key: "user_id", dependent: :destroy
  has_many :user_sport_interests, dependent: :destroy
  has_many :sports, through: :user_sport_interests
end
