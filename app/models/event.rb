class Event < ApplicationRecord
  validates_presence_of :title, :description, :event_time, :creator
end
