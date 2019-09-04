class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      render json: UserSerializer.new(user), status: 201
    else
      render json: { error: 'Failed to register' }, status: 422
    end
  end

  private

  def user_params
    params.permit(:first_name, :last_name, :phone_number, :email, :password, :password_confirmation)
  end
end
