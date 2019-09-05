class Api::V1::EventsController < ApplicationController
  def index
    render json: Event.all
  end

  def create
    user = User.find_by(api_key: params[:api_key])
    if user
      event = Event.new(event_params)
      event.creator = "#{user.first_name} #{user.last_name}"
      if event.save
        render json: EventSerializer.new(event), status: 201
      else 
        render json: { error: 'Failed to create event'}, status: 422
      end
    else 
      render json: { error: 'Failed to find user' }, status: 404
    end
  end

    def event_params
      params.permit(:title, :description, :event_time, :event_location)
  end
end
