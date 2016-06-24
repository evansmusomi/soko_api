class Api::V1::ProductsController < ApplicationController
  respond_to :json

  # Show product catalog
  def index
    respond_with Product.all
  end

  # Get a specified product's details
  def show
    respond_with Product.find(params[:id])
  end
end
