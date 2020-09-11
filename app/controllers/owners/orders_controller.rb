class Owners::OrdersController < ApplicationController
  before_action :authenticate_owner!

	def index
		@orders = Order.all.page(params[:page]).per(10)
	end

	def show
	end

	def update
	end

	private
	def order_status
	    params.require(:order).permit(:order_status)
	end
end