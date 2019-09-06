class EventSerializer
  include FastJsonapi::ObjectSerializer
  set_type :event
  set_id :id
  attributes :title, :description, :creator, :event_location

  attribute :event_time do |object|
    Time.at(object.event_time).strftime('%I:%M%p %m/%d/%y')
  end

  attribute :attendees do |object|
    object.users.map {|user| "#{user.first_name} #{user.last_name}"}
  end
end
