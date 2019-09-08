class Api::V1::FriendshipsController < ApplicationController
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

  def update
    user = User.find_by(api_key: params[:api_key])
    if user
      requestee_user = User.find_by(id: params[:id])
      if requestee_user
        user.accept_request(requestee_user)
        accept_facade = AcceptFacade.new(user, requestee_user)
        render json: AcceptSerializer.new(accept_facade), status: 202
      else
        render json: { error: 'Failed to find requesting user' }, status: 404
      end
    else
      render json: { error: 'Failed to find user' }, status: 404
    end
  end

  def destroy
    user = User.find_by(api_key: params[:api_key])
    if user
      remove_user = User.find_by(id: params[:id])
      if remove_user
        user.remove_friend(remove_user)
        head :no_content
      else
        render json: { error: 'Failed to find requesting user' }, status: 404
      end
    else
      render json: { error: 'Failed to find user' }, status: 404
    end
  end
end
