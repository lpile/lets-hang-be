class Api::V1::User::EventsController < ApplicationController
  def index
    user = User.find_by(api_key: params[:api_key])
    render json: UserEventsSerializer.new(user), status: 200
  end
end