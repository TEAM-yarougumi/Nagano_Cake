class Owners::CustomersController < ApplicationController
  # before_action :authenticate_owner!

def index
  @customer = Customer.all
end

def show_owner
	@customer = Customer.find(params[:id])
end

def edit_owner
end

def update_owner
end

end
