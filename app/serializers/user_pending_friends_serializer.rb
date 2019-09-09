class UserPendingFriendsSerializer
  include FastJsonapi::ObjectSerializer
  set_type :user
  set_id :id
  attribute :pending_friends do |object|
    object.pending_friends.map do |friend|
      {"id": friend.id,
       "Name": friend.first_name + ' ' + friend.last_name,
       "Phone Number": friend.phone_number,
       "Email": friend.email
      }
    end
  end
end
