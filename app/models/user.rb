class User < ApplicationRecord
  before_validation :create_api_key

  # Sets up relationship between user and event
  has_many :user_events
  has_many :events, through: :user_events

  # Sets up relationship between user and other users called friends
  has_many :friendships
  has_many :friends, -> { where friendships: { status: :accepted } }, through: :friendships
  has_many :requested_friends, -> { where friendships: { status: :requested } }, through: :friendships, source: :friend
  has_many :pending_friends, -> { where friendships: { status: :pending } }, through: :friendships, source: :friend
  has_many :blocked_friends, -> { where friendships: { status: :blocked } }, through: :friendships, source: :friend

  # Validates model attributes
  validates :email, uniqueness: true, presence: true
  validates_presence_of :first_name, :last_name, :phone_number, require: true

  # For Bcrypt to hash user's password
  has_secure_password

  def friend_request(friend)
    unless self == friend || Friendship.where(user: self, friend: friend).exists?
      transaction do
        Friendship.create(user: self, friend: friend, status: :pending)
        Friendship.create(user: friend, friend: self, status: :requested)
      end
    end
  end

  def accept_request(friend)
    transaction do
      Friendship.find_by(user: self, friend: friend, status: [:requested])&.accepted!
      Friendship.find_by(user: friend, friend: self, status: [:pending])&.accepted!
    end
  end

  def reject_request(friend)
    transaction do
      Friendship.find_by(user: self, friend: friend)&.destroy!
      Friendship.find_by(user: friend, friend: self)&.destroy!
    end
  end

  private

  def create_api_key
    self.api_key = SecureRandom.hex(10)
  end
end
