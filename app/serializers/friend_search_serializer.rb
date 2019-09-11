class FriendSearchSerializer
  include FastJsonapi::ObjectSerializer
  set_type :search_friend
  set_id :id
  attribute :name do |object|
    "#{object.first_name} #{object.last_name}"
  end

  attributes :phone_number, :email
end
