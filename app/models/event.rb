class Event < ApplicationRecord
  has_many :user_events
  has_many :users, through: :user_events

  validates_presence_of :title, :description, :event_time, :creator
end
