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
  @customer = Customer.find(params[:id])
  @customer.update(customers_params)
  if @customer.save
    redirect_to owners_customers_path
    end
end
private
    def customers_params
      params.require(:customer).permit(:email, :last_name, :first_name, :last_furigana, :first_furigana, :postal_code,:address, :telephone_number, :status)
    end
end



