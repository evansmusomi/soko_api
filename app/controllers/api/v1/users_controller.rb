class Api::V1::UsersController < ApplicationController
  respond_to :json

  #respond with user details
  def show
    respond_with User.find(params[:id])
  end

  #create new user based on permitted attributes
  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: 201, location: [:api, user]
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  private
    #permitted parameters
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
