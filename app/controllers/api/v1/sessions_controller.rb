class Api::V1::SessionsController < ApplicationController

  # Handles log in request
  def create
    # Identify user using inputs
    user_email = params[:session][:email]
    user_password = params[:session][:password]
    user = user_email.present? && User.find_by(email: user_email)

    # Authenticate user
    if user.valid_password? user_password
      sign_in user, store: false
      user.generate_authentication_token!
      user.save
      render json: user, status: 200, location: [:api, user]
    else
      render json: { errors: "Invalid email or password" }, status: 422
    end
  end

  # Voids previous user authentication token
  def destroy
    user = User.find_by(auth_token: params[:id])
    user.generate_authentication_token!
    user.save
    head 204
  end
end
