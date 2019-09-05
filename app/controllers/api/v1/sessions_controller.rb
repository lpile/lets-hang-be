class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by_email(user_params[:email])
    if user&.authenticate(params[:password])
      render json: UserSerializer.new(user), status: 200
    else
      render json: { error: 'Failed to login' }, status: 422
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
