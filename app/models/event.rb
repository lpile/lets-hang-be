class Event < ApplicationRecord
  has_many :user_events
  has_many :accepts, -> { where user_events: { status: :accepted } }, through: :user_events, source: :user
  has_many :pendings, -> { where user_events: { status: :pending } }, through: :user_events, source: :user
  has_many :declines, -> { where user_events: { status: :declined } }, through: :user_events, source: :user

  validates_presence_of :title, :description, :event_time, :creator, :event_location
end
