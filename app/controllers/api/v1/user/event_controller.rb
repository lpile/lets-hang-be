class Api::V1::User::EventController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])
    
    if user
      event = Event.find_by(id: params[:id])
      
      if event && event.creator == "#{user.first_name} #{user.last_name}"
        friends = params["friend_ids"]
        
        invited_friends = friends.map|friend| do
          current_friend = User.find_by(id: friend.id) 
          UserEvent.create(user: current_friend.id, event: event.id, status: pending)
        end

        if invited_friends
          event = Event.find_by(id: params[:id])
          render json: EventSerializer.new(event), status: 201
        else
          render json: { error: 'Failed to invite' }, status: 422
        end

      else 
        render json: { error: 'Failed to find event' }, status: 404
      end

    else
      render json: { error: 'Failed to find user' }, status: 404
    end

  end
end

