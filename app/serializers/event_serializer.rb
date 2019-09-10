class EventSerializer
  include FastJsonapi::ObjectSerializer
  set_type :event
  set_id :id
  attributes :title, :description, :creator, :event_time, :event_location

  attribute :invited do |object|
    object.pendings.map do |user|
      {
      'id': user.id,
      'name': user.first_name + ' ' + user.last_name
      }
    end
  end

  attribute :accepted do |object|
    object.accepts.map do |user|
      {
      'id': user.id,
      'name': user.first_name + ' ' + user.last_name
      }
    end
  end

  attribute :declined do |object|
    object.declines.map do |user|
      {
      'id': user.id,
      'name': user.first_name + ' ' + user.last_name
      }
    end
  end
end
