class EventSerializer
  include FastJsonapi::ObjectSerializer
  set_type :event
  set_id :id
  attributes :title, :description, :creator, :event_time, :event_location

  attribute :attendees do |object|
    object.users.map {|user| "#{user.first_name} #{user.last_name}"}
  end
end
