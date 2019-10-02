class UserEventsSerializer
  include FastJsonapi::ObjectSerializer
  set_type :user
  set_id :id
  attribute :events do |object|
    object.events.map do |event|
      # binding.pry
      {
       "id": event.id,
       "title": event.title,
       "description": event.description,
       "event_time": event.event_time,
       "event_location": event.event_location,
       "creator": event.creator,
       "attending": event.accepts.map { |user| user.first_name + ' ' + user.last_name }
      }
    end
  end
end
