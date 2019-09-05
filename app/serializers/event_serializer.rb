class EventSerializer
  include FastJsonapi::ObjectSerializer
  set_type :event
  set_id :id
  attributes :title, :description, :creator, :event_location
  attribute :event_time do |object|
    Time.at(object.event_time).strftime('%I:%M%p %m/%d/%y')
  end
end
