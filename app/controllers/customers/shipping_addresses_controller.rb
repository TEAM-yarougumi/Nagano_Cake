class Customers::ShippingAddressesController < ApplicationController
	before_action :authenticate_customer!

	def index
		@shipping_address = ShippingAddress.new
		@shipping_addresses = ShippingAddress.where(customer_id: current_customer.id)
	end

	def create
		# Customer、Shipping_addressそれぞれのアドレス情報を検索して、存在しない場合のみShipping_addressに登録
		if (current_customer.postal_code != params[:shipping_address][:shipping_postal_code] && current_customer.address != params[:shipping_address][:shipping_address] && current_customer.last_name + current_customer.first_name != params[:shipping_address][:address_name]) && (current_customer.shipping_addresses.where(shipping_postal_code: params[:shipping_address][:shipping_postal_code], shipping_address: params[:shipping_address][:shipping_address], address_name: params[:shipping_address][:address_name]).blank?)

			@shipping_address = ShippingAddress.new(shipping_address_params)
			@shipping_address.customer_id = current_customer.id
			if @shipping_address.save
				flash[:success] = "配送先の作成に成功しました！"
			else
				@shipping_addresses = ShippingAddress.where(customer_id: current_customer.id)
				render "index" and return
			end
		else
			flash[:notice] = "既に登録されている配送先、もしくはご自身の住所と同一です。ご自身の住所の変更はマイページから行ってください。"
		end
		@shipping_address = ShippingAddress.new
		redirect_to customer_shipping_addresses_path(current_customer.id)
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
