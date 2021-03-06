class Api::V1::User::EventsController < ApplicationController
  def index
    user = User.find_by(api_key: params[:api_key])
    if user
      render json: UserEventsSerializer.new(user), status: 200
    else
      render json: { error: 'Failed to find user' }, status: 404
    end
  end
end
