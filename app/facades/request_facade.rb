class RequestFacade
  def initialize(user, friend)
    @user = user
    @friend = friend
    @user_friendship = Friendship.find_by(user: user, friend: friend, status: :pending)
    @friend_friendship = Friendship.find_by(user: friend, friend: user, status: :requested)
  end

  def id
    user_friendship.id
  end

  def requester
    {
      id: user.id,
      name: user.first_name + ' ' + user.last_name,
      status: user_friendship.status
    }
  end

  def requestee
    {
      id: friend.id,
      name: friend.first_name + ' ' + friend.last_name,
      status: friend_friendship.status
    }
  end

  private

  attr_reader :user, :friend, :user_friendship, :friend_friendship
end
