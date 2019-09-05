class EventSerializer
  include FastJsonapi::ObjectSerializer
  set_type :event
  set_id :id
  attributes :title, :description, :event_time, :creator, :event_location
end
