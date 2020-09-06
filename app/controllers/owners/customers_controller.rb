class Owners::CustomersController < ApplicationController
  # before_action :authenticate_owner!

def index
  @customer = Customer.all
end

def show_owner
end

def edit_owner
  @customer = Customer.find(params[:id])
end

def update_owner
end

end
