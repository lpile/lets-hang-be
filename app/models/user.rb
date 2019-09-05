class User < ApplicationRecord
  before_validation :create_api_key

  # Sets up relationship between user and event
  has_many :user_events
  has_many :events, through: :user_events

  # Sets up relationship between user and other users called friends
  has_many :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"

  # Validates model attributes
  validates :email, uniqueness: true, presence: true
  validates_presence_of :first_name, :last_name, :phone_number, require: true

  # For Bcrypt to hash user's password
  has_secure_password

  private

  def create_api_key
    self.api_key = SecureRandom.hex(10)
  end
end
