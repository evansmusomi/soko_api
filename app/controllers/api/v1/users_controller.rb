class Api::V1::UsersController < ApplicationController
  # Hooks
  before_action :authenticate_with_token!, only: [:update, :destroy]
  
  # Accepted format
  respond_to :json

  # Respond with user details
  def show
    respond_with User.find(params[:id])
  end

  # Create new user based on permitted attributes
  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: 201, location: [:api, user]
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  # Update existing user
  def update
    user = current_user

    if user.update(user_params)
      render json: user, status: 200, location: [:api, user]
    else
      render json: {errors: user.errors }, status: 422
    end
  end

  # Delete existing user
  def destroy
    current_user.destroy
    head 204
  end

  private
    # Permitted parameters
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
