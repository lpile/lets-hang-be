class AcceptFacade
  def initialize(user, requester)
    @user = user
    @requester_user = requester
    @user_friendship = Friendship.find_by(user: user, friend: requester)
    @requester_user_friendship = Friendship.find_by(user: requester_user, friend: user)
  end

  def id
    user_friendship.id
  end

  def requester
    {
      id: requester_user.id,
      name: requester_user.first_name + ' ' + requester_user.last_name,
      status: requester_user_friendship.status
    }
  end

  def requestee
    {
      id: user.id,
      name: user.first_name + ' ' + user.last_name,
      status: user_friendship.status
    }
  end

  private

  attr_reader :user, :requester_user, :user_friendship, :requester_user_friendship
end
