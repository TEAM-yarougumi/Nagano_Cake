class Owners::OrdersController < ApplicationController
  before_action :authenticate_owner!

	def index
		case params[:order_index_source]
			when "from_header"
				@orders = Order.all.page(params[:page]).per(10)
				@order_index_source = params[:order_index_source]
			when "from_top"
				@orders = Order.where(created_at: Time.zone.now.all_day).page(params[:page]).per(10)
				@order_index_source = params[:order_index_source]
			when "from_show_owner"
				@orders = Order.where(customer_id: params[:customer_source]).all.page(params[:page]).per(10)
				@order_index_source = params[:order_index_source]
		end
	end

	def show
		@order = Order.find(params[:id])
		@sum = 0
	end

	def update
		@order = Order.find(params[:id])
		@order.update(orders_params)
			if params[:order][:status] == "payment_confirm"
				@order.order_items.each do |order_item|
					order_item.standby_making!
				end
				flash[:notice] = "注文の入金が確認できたので、商品の製品ステータスを製作待ちに更新しました！"
			else
				flash[:notice] = "注文ステータスを更新しました！"
			end
		redirect_to owners_orders_path
	end
	
	def update_order
		@order = Order.find(params[:order_item][:order_id])
		@order_item = OrderItem.find(params[:id])
		@order_items = OrderItem.where(order_id: params[:order_item][:order_id])		
		@order_item.item_status = params[:order_item][:item_status]
		@order_item.update(order_item_params)
		if @order_items.where(item_status: "making").count == 1 && @order_items.where(item_status: "making_finish").count != @order_items.count - 1
			@order.making!
			flash[:notice] = "製作ステータスおよび注文ステータスを製作中に更新しました！"
		end
		if @order_items.where(item_status: "making_finish").count == @order_items.count
			@order.ready_to_ship!
			flash[:notice] = "注文された商品の製作が完了したので、注文ステータスを発送準備中に更新しました！"
		else
			flash[:notice] = "商品の製作ステータスを更新しました！"
		end			
		redirect_to owners_orders_path
	end

	private
	def orders_params
		params.require(:order).permit(:customer_id, :postage, :billing_amount, :payment, :address, :postal_code, :status, :address_name)
	end
	def order_item_params
		params.require(:order_item).permit(:item_status)
	end
end
