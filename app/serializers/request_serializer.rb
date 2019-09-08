class RequestSerializer
  include FastJsonapi::ObjectSerializer
  set_type :request
  set_id :id
  attributes :requester, :requestee
end
