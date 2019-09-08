class Api::V1::Event::InviteController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])
    if user
      event = Event.find_by(id: params[:event_id])
      if event && event.creator == "#{user.first_name} #{user.last_name}"
        friend = User.find_by(id: params[:friend_id])
        UserEvent.create(user: friend, event: event, status: 0)
        render json: UserEventsSerializer.new(user), status: 201
      else 
        render json: { error: 'Failed to invite friend' }, status: 422
      end
    else
      render json: { error: 'Failed to find user' }, status: 404
    end
  end
end
