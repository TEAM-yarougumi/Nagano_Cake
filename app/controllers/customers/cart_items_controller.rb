class Customers::CartItemsController < ApplicationController
	before_action :authenticate_customer!

	def index
		@items = current_customer.cart_items.all
	end

	def create
	end

	def update
	end

	def destroy
	end

	def all_destroy
	end

end
