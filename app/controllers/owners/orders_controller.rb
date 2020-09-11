class Owners::OrdersController < ApplicationController
  before_action :authenticate_owner!

	def index
		@order = Order.all
		@orders = Order.all.page(params[:page]).per(10)
	end

	def show
		@order = Order.find(params[:id])
		@sum = 0
	end

	def update
		@order = Order.find(params[:id])
	end

	private
	def order_status
	    params.require(:order).permit(:order_status)
	end
end