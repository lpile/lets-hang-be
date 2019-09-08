class Api::V1::UserEventsController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])
    if user
      event = Event.find_by(id: params[:event_id])
      if event && event.creator == "#{user.first_name} #{user.last_name}"
        friend = User.find_by(id: params[:friend_id])
        user_event = UserEvent.create(user: friend, event: event, status: 0)
        render json: EventInviteSerializer.new(user_event), status: 201
      else 
        render json: { error: 'Failed to invite friend' }, status: 422
      end
    else
      render json: { error: 'Failed to find user' }, status: 404
    end
  end


#Invited user accepting 
def update
  user = User.find_by(api_key: params[:api_key])
    if user
      event = Event.find_by(id: params[:event_id])
      if event 
        UserEvent.update(user: friend, event: event, status: 1)
        render json: UserEventsSerializer.new(user), status: 202
      else 
        render json: { error: 'Failed to find event' }, status: 404
      end
    else
      render json: { error: 'Failed to find user' }, status: 404
    end
  end

end