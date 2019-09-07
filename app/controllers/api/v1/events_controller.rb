class Api::V1::EventsController < ApplicationController
  def index
    render json: AllEventsSerializer.new(Event.all), status: 200
  end

  def show
    user = User.find_by(api_key: params[:api_key])
    if user
      event = Event.find_by(id: params[:id])
      if event
        if event.creator == "#{user.first_name} #{user.last_name}"
          render json: EventSerializer.new(event), status: 200
        else
          render json: { error: 'Unauthorized user' }, status: 401
        end
      else
        render json: { error: 'Failed to find event' }, status: 404
      end
    else
      render json: { error: 'Failed to find user' }, status: 404
    end
  end

  def create
    user = User.find_by(api_key: params[:api_key])
    if user
      event = Event.new(event_params)
      event.creator = "#{user.first_name} #{user.last_name}"
      if event.save
        UserEvent.create(user: user, event: event)
        render json: EventSerializer.new(event), status: 201
      else
        render json: { error: 'Failed to create event'}, status: 422
      end
    else
      render json: { error: 'Failed to find user' }, status: 404
    end
  end

  def update
    user = User.find_by(api_key: params[:api_key])
    if user
      event = Event.find_by(id: params[:id])
      if event && event.creator == "#{user.first_name} #{user.last_name}"
          event.update(event_params)
            render json: EventSerializer.new(event), status: 202
      else 
        render json: { error: 'Failed to update event' }, status: 422
      end
    else
      render json: { error: 'Failed to find user' }, status: 404
    end
  end

  private

  def event_params
    params.permit(:title, :description, :event_time, :event_location)
  end
end
