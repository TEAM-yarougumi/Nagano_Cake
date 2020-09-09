class Customers::OrdersController < ApplicationController
    before_action :authenticate_customer!

    def index
    end

    def create
        @order =Order.new(order_params)
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
        if params[:choice_shipping_address] == "my_address"
            @customer = Customer.find(params[:customer_id])
            @order = Order.new
            @order.postal_code = @customer.postal_code
            @order.address = @customer.address
            @order.address_name = @customer.last_name, @customer.first_name

            @cart_items = CartItem.all
            @cart_item = CartItem.find(params[:id])
            @cart_item_tax_price =  (@cart_item.item.no_tax_price * 1.1).floor
            @cart_items_total_price = @cart_item_tax_price * @cart_item.number.sum

        elsif params[:choice_shipping_address] == "registered_address"
            @order = Order.new
            @shipping_address = ShippingAddress.find(params[:choice_pulldown])
            @order.postal_code = @shipping_address.shipping_postal_code
            @order.address = @shipping_address.shipping_address
            @order.address_name = @shipping_address.address_name

            @cart_items = CartItem.all
            @cart_item = CartItem.find(params[:id])
            @cart_item_tax_price =  (@cart_item.item.no_tax_price * 1.1).floor
            @cart_items_total_price = @cart_item_tax_price * @cart_item.number.sum

        else
            @order = Order.new
            @order.postal_code = params[:postal_code]
            @order.address = params[:address]
            @order.address_name = params[:address_name]

            @cart_items = CartItem.all
            @cart_item = CartItem.find(params[:id])
            @cart_item_tax_price =  (@cart_item.item.no_tax_price * 1.1).floor
            @cart_items_total_price = @cart_item_tax_price * @cart_item.number.sum
        end
    end
    
    def complete
    end

    private
    def order_params
        params.require(:order).permit(:payment, :address_name, :address, :postal_code)
        
    end
end
