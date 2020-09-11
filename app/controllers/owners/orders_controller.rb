class Owners::OrdersController < ApplicationController
  before_action :authenticate_owner!

  def index
  	   @orders = Order.page(params[:page]).per(3).order('created_at DESC')
  end

  def show
  	   @order = Order.find(params[:id])
  end

  def update
       @order = Order.find(params[:id])
       @order.update(orders_params)
       @orderitems = @order.order_items.all
      if @order.orders_status == "deposit"
        @orderitems.each do |order_item|
        order_item.update(production_status: :waiting)
         end
        redirect_to admins_order_path(@order.id)
      else
        render :show
      end
  end

  private

  def orders_params
    params.require(:order).permit(:orders_status)
  end

end
