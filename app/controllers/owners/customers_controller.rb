class Owners::CustomersController < ApplicationController
  # before_action :authenticate_owner!

def index
  @customer = Customer.all
end

def show_owner
	@customer = Customer.find(params[:id])
end

def edit_owner
  @customer = Customer.find(params[:id])
end

def update_owner
  @customer = Customer.find(params[:id])
  if @customer.save
    redirect_to owners_customers_path
    end
end

end
