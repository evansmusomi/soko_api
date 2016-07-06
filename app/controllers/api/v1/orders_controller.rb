class Api::V1::OrdersController < ApplicationController
  before_action :authenticate_with_token!
  respond_to :json

  # Shows list of current users orders
  def index
    orders = current_user.orders.page(params[:page]).per(params[:per_page])
    render json: orders, meta: { pagination: {
        per_page: params[:per_page],
        total_pages: orders.total_pages,
        total_objects: orders.total_count
      }
    }
  end

  # Shows specific order belonging to user
  def show
    respond_with current_user.orders.find(params[:id])
  end

  # Creates new order for current user
  def create
    order = current_user.orders.build
    order.build_placements_with_product_ids_and_quantities(params[:order][:product_ids_and_quantities])

    if order.save
      order.reload # reload object so response displays product objects
      OrderMailer.send_confirmation(order).deliver_now
      render json: order, status: 201, location: [:api, current_user, order]
    else
      render json: { errors: order.errors }, status: 422
    end
  end

  private
    # Sets permitted parameters
    def order_params
      params.require(:order).permit(:product_ids => [])
    end
end
