class UserFriendsSerializer
  include FastJsonapi::ObjectSerializer
  set_type :user
  set_id :id
  attribute :accepted_friends do |object|
    object.friends.map do |friend|
      {
        "id": friend.id,
        "name": friend.first_name + ' ' + friend.last_name,
        "phone_number": friend.phone_number,
        "email": friend.email
      }
    end
  end

  attribute :pending_friends do |object|
    object.pending_friends.map do |friend|
      {
        "id": friend.id,
        "name": friend.first_name + ' ' + friend.last_name,
        "phone_number": friend.phone_number,
        "email": friend.email
      }
    end
  end

  attribute :requested_friends do |object|
    object.requested_friends.map do |friend|
      {
        "id": friend.id,
        "name": friend.first_name + ' ' + friend.last_name,
        "phone_number": friend.phone_number,
        "email": friend.email
      }
    end
  end
end
