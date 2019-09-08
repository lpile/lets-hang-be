class EventInviteSerializer
  include FastJsonapi::ObjectSerializer
  set_type :user_event
  set_id :id
  attributes :user_id, :event_id, :status
end