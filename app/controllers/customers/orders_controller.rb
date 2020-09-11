class Customers::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def index
    @orders = current_customer.orders
  end

  def create
    if current_customer.cart_items.exists?
      #お届け先によって保存内容を場合分け
      @order = Order.new(order_params)
      @order.customer_id = current_customer.id
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.address_name = params[:order][:address_name]
      @order.billing_amount = params[:order][:billing_amount]
      @order.save

      #今回使われた配送先が新規のものであれば、配送先に新規登録
      if ShippingAddress.find_by(shipping_address: @order.address).nil? && current_customer.address != @order.address
        @shipping_address = ShippingAddress.new
        @shipping_address.shipping_postal_code = @order.postal_code
        @shipping_address.shipping_address = @order.address
        @shipping_address.address_name = @order.address_name
        @shipping_address.customer_id = current_customer.id
        @shipping_address.save
      end

      #cart_itemsの内容をorder_itemsに新規登録
      current_customer.cart_items.each do |cart_item|
        order_item = @order.order_items.build
        order_item.order_id = @order.id
        order_item.item_id = cart_item.item_id
        order_item.number = cart_item.number
        order_item.buy_price = (cart_item.item.no_tax_price * 1.1).floor
        order_item.save
        cart_item.destroy #order_itemsに新規登録後はカートの中を空にする
      end
      redirect_to complete_path(current_customer.id, @order.id)
    else
      redirect_to root_path
      flash[:danger] = "カートが空です。"
    end
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
    @items = @order.items
  end

  def new
    @order = Order.new
    @shipping_addresses = ShippingAddress.where(customer_id: current_customer.id)
  end

  def confirm    
    #注文情報入力画面でのお届け先選択によって分岐
    @order = Order.new
    if params[:choice_shipping_address] == "my_address"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.address_name = current_customer.last_name + current_customer.first_name
      @cart_items = current_customer.cart_items

    elsif params[:choice_shipping_address] == "registered_address"
      @shipping_address = ShippingAddress.find(params[:choice_pulldown])
      @order.postal_code = @shipping_address.shipping_postal_code
      @order.address = @shipping_address.shipping_address
      @order.address_name = @shipping_address.address_name
      @cart_items = current_customer.cart_items

    else
      @order.postal_code = params[:postal_code]
      @order.address = params[:address]
      @order.address_name = params[:address_name]
      @cart_items = current_customer.cart_items
    end
  end
  
  def complete
  end

  private
  def order_params
    params.require(:order).permit(:payment, :address_name, :address, :postal_code, :choice_pulldown)
  end
end
