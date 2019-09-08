class AcceptSerializer
  include FastJsonapi::ObjectSerializer
  set_type :accept
  set_id :id
  attributes :requester, :requestee
end
