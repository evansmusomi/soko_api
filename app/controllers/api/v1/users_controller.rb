class Api::V1::UsersController < ApplicationController
  respond_to :json

  def show
    #respond with user details
    respond_with User.find(params[:id])
  end
end
