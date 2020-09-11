class Customers::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def index
  end

  def create
    binding.pry
    @order = Order.new(order_params)
    if params[:order][:choice_shipping_address] == "my_address"
      @order.customer_ID = current_customer.id
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.address_name = current_customer.last_name + current_customer.first_name
      @order.billing_amount = params[:order][:billing_amount]
    elsif params[:order][:choice_shipping_address] == "registered_address"
      @order.customer_ID = current_customer.id
      @shipping_address = ShippingAddress.find(params[:choice_pulldown])
      @order.postal_code = @shipping_address.shipping_postal_code
      @order.address = @shipping_address.shipping_address
      @order.address_name = @shipping_address.address_name
      @order.billing_amount = params[:order][:billing_amount]
    else
      @order.customer_ID = current_customer.id
      @order.postal_code = params[:postal_code]
      @order.address = params[:address]
      @order.address_name = params[:address_name]
      @order.billing_amount = params[:order][:billing_amount]
    end

    binding.pry
    if @order.save
      redirect_to complete_path(current_customer.id, @order.id)
    else
      render 'root'
    end
  end

  def thanks
  end

  def show
  end

  def new
    @order = Order.new
    @customer = Customer.find(params[:customer_id])
    @shipping_addresses = ShippingAddress.all
  end

  def confirm
    binding.pry
    if params[:choice_shipping_address] == "my_address"
      @customer = Customer.find(params[:customer_id])
      @order = Order.new
      @order.postal_code = @customer.postal_code
      @order.address = @customer.address
      @order.address_name = @customer.last_name + @customer.first_name
      @choice_shipping_address = params[:choice_shipping_address]
      @cart_items = CartItem.all

    elsif params[:choice_shipping_address] == "registered_address"
      @order = Order.new
      @shipping_address = ShippingAddress.find(params[:choice_pulldown])
      @order.postal_code = @shipping_address.shipping_postal_code
      @order.address = @shipping_address.shipping_address
      @order.address_name = @shipping_address.address_name
      @choice_shipping_address = params[:choice_shipping_address]
      @cart_items = CartItem.all
      

    else
      @order = Order.new(order_params)
      @choice_shipping_address = params[:choice_shipping_address]
      @cart_items = CartItem.all
    end
  end
  
  def complete
  end

  private
  def order_params
    params.require(:order).permit(:payment, :address_name, :address, :postal_code, :choice_pulldown)
  end
end
