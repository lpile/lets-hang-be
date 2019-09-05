class Api::V1::User::EventsController < ApplicationController
  def index
    user = User.find_by(api_key: params[:api_key])
    if user.events
      render json: UserEventsSerializer.new(user), status: 200
    else 
      render json: { error: 'No events found' }
    end
  end
end