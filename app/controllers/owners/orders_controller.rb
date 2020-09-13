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
		
		if @order.update(orders_params)
			flash[:notice] = "更新しました！"
			if @order.status == "payment_confirm"
				@order.order_items.each do |order_item|
					order_item.standby_making!
				end	
		  end
			redirect_to owners_orders_path
		end
	end

	def update_order
		@order = Order.find(params[:order_item][:order_id])
		@order_item = OrderItem.find(params[:id])
		@order_items = OrderItem.where(order_id: params[:order_item][:order_id])
		if @order_item.update(order_items_params)
			flash[:notice] = "更新しました！"
			if @order_item.item_status == "making"
				@order.making!
			end
			binding.pry
			if @order_items.item_status  == "making_finish"
				@order.ready_to_ship!
			end
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
end