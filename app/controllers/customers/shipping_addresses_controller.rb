class Customers::ShippingAddressesController < ApplicationController
  before_action :authenticate_customer!

    def index
        @shipping_address = ShippingAddress.new
        @shipping_addresses = ShippingAddress.all
    end

    def create
        @shipping_address = ShippingAddress.new(shipping_address_params)
        @shipping_address.customer_id = current_customer.id

        if @shipping_address.save
            redirect_to customer_shipping_addresses_path
        else
            render "index"
        end
    end

    def destroy
        @shipping_address = ShippingAddress.find(params[:id])
        @shipping_address.destroy
        redirect_to customer_shipping_addresses_path
    end

    def edit
    end
    
    def update
    end


    private
    def shipping_address_params
        params.require(:shipping_address).permit(:address_name,:shipping_address,:shipping_postal_code)
    end
end
