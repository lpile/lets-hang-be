class UserRequestedFriendsSerializer
  include FastJsonapi::ObjectSerializer
  set_type :user
  set_id :id
  attribute :requested_friends do |object|
    object.requested_friends.map do |friend|
      {"id": friend.id,
       "Name": friend.first_name + ' ' + friend.last_name,
       "Phone Number": friend.phone_number,
       "Email": friend.email
      }
    end
  end
end
