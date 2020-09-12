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

		@order.update(orders_params)
			if @order.save
			flash[:notice] = "更新しました！"
			redirect_to owners_orders_path
			end	
	def update_order
		@order_item = OrderItem.find(params[:id])
		@order_item.update(order_items_params)
			if @order_item.save
				flash[:notice] = "更新しました！"
				redirect_to owners_orders_path
			end	
	end

	private
	def orders_params
		params.require(:order).permit(:customer_id, :postage, :billing_amount, :payment, :address, :postal_code, :status, :address_name )
	end
	def order_items_params
		  params.require(:order_item).permit(:item_status)
end