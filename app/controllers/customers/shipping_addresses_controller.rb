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
      flash[:success] = "配送先の作成に成功しました！"
		else
      @shipping_addresses = ShippingAddress.all
			render "index"
		end
	end

	def destroy
		@shipping_address = ShippingAddress.find(params[:id])
		if @shipping_address.destroy
      flash[:success] = "配送先の削除に成功しました！"
      redirect_to customer_shipping_addresses_path
    end
	end

	def edit
    @shipping_address = ShippingAddress.find(params[:id])
	end
	
	def update
		@shipping_address = ShippingAddress.find(params[:id])
		if @shipping_address.update(shipping_address_params)
      flash[:success] = "配送先の更新に成功しました！"
      redirect_to customer_shipping_addresses_path(current_customer.id)
		else
      render :edit
		end
	end

	private
	def shipping_address_params
		params.require(:shipping_address).permit(:address_name,:shipping_address,:shipping_postal_code)
	end
end
