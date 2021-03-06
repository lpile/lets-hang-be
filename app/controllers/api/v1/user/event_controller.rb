class Api::V1::User::EventController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])
    if user
      event = Event.find_by(id: params[:id])

      if event && event.creator == "#{user.first_name} #{user.last_name}"
        friends = params["friend_ids"]

        # Assigns user to events by creating row in UserEvent table
        friends.each do |id|
          user = User.find_by(id: id)
          UserEvent.create(user: user, event: event, status: :pending)
        end

        render json: EventSerializer.new(event), status: 201
      else
        render json: { error: 'Failed to find event' }, status: 404
      end
    else
      render json: { error: 'Failed to find user' }, status: 404
    end
  end

  def update
    user = User.find_by(api_key: params[:api_key])
    if user
      event = Event.find_by(id: params[:id])
      if event
        user_event = UserEvent.find_by(user: user, event: event)

        user_event.update(status: :accepted)

        render json: EventSerializer.new(event), status: 202
      else
        render json: { error: 'Failed to find event' }, status: 404
      end
    else
      render json: { error: 'Failed to find user' }, status: 404
    end
  end

  def destroy
    user = User.find_by(api_key: params[:api_key])
    if user
      event = Event.find_by(id: params[:id])
      if event
        user_event = UserEvent.find_by(user: user, event: event)

        user_event.update(status: :declined)

        render json: EventSerializer.new(event), status: 202
      else
        render json: { error: 'Failed to find event' }, status: 404
      end
    else
      render json: { error: 'Failed to find user' }, status: 404
    end
  end
end
