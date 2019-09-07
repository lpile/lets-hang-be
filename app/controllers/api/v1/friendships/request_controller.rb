class Api::V1::Friendships::RequestController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])
    if user
      friend = User.find_by(id: params[:friend_id])
      if friend
        user.friend_request(friend)
        request_facade = RequestFacade.new(user, friend)
        render json: RequestSerializer.new(request_facade), status: 201
      else
        render json: { error: 'Failed to find friend' }, status: 404
      end
    else
      render json: { error: 'Failed to find user' }, status: 404
    end
  end

  def destroy
    user = User.find_by(api_key: params[:api_key])
    if user
      requesting_user = User.find_by(id: params[:request_id])
      if requesting_user
        user.reject_request(requesting_user)
        render json: { message: 'Pending friend request has been removed' }, status: 202
      else
        render json: { error: 'Failed to find requesting user' }, status: 404
      end
    else
      render json: { error: 'Failed to find user' }, status: 404
    end
  end
end
