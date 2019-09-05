class UserEventsSerializer
  include FastJsonapi::ObjectSerializer
  set_type :user
  set_id :id
  attribute :events do |object|
    object.events.map do |event|
      {"Title": event.title,
       "Description": event.description,
       "Time": event.event_time,
       "Location": event.event_location,
       "Creator": event.creator
      }
    end
  end
end
