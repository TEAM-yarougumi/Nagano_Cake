class Customer::ShippingAddressesController < ApplicationController
    def index
    end

    def create
    end

    def destroy
    end

    def edit
    end
    
    def update
    end


    private
  def shipping_addresses_params
    params.require(:shipping_addresses).permit(:address_name,:shipping_address,:shipping_postal_code)
  end
end
