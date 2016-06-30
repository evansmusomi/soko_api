class Api::V1::OrdersController < ApplicationController
  before_action :authenticate_with_token!
  respond_to :json

  # Shows list of current users orders
  def index
    respond_with current_user.orders
  end

  # Shows specific order belonging to user
  def show
    respond_with current_user.orders.find(params[:id])
  end

  # Creates new order for current user
  def create

  end
end
