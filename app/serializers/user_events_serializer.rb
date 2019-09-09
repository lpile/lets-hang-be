class UserEventsSerializer
  include FastJsonapi::ObjectSerializer
  set_type :user
  set_id :id
  attribute :events do |object|
    object.events.map do |event|
      {"id": event.id,
       "Title": event.title,
       "Description": event.description,
       "Time": Time.at(event.event_time).strftime('%I:%M%p %m/%d/%y'),
       "Location": event.event_location,
       "Creator": event.creator
      }
    end
  end
end
