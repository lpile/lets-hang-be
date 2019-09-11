class Api::V1::User::SearchController < ApplicationController
  def show
    user = User.find_by(api_key: params[:api_key])
    if user
      query = params[:query].split(" ")

      friend = User.where("first_name ILIKE ? AND last_name ILIKE ?", "#{query[0]}","#{query[1]}" ).first
      if friend
        render json: FriendSearchSerializer.new(friend), status: 200
      else
        render json: { error: 'User is not in database' }, status: 404
      end
    else
      render json: { error: 'Failed to find user' }, status: 404
    end
  end
end
