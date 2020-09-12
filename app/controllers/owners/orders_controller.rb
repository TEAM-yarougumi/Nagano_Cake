class Owners::OrdersController < ApplicationController
  before_action :authenticate_owner!

	def index
		@order = Order.all
		@orders = Order.all.page(params[:page]).per(10)
	end

	def show
		@order = Order.find(params[:id])
	end

	def update
		@order = Order.find(params[:id])
		@order.update(orders_params)
			if @order.save
			flash[:notice] = "更新しました！"
			redirect_to owners_orders_path
			end	
	end

	private
	def orders_params
	    params.require(:order).permit(:customer_id, :postage, :billing_amount, :payment, :address, :postal_code, :status, :address_name)
	end
end