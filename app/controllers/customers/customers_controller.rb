class Customers::CustomersController < ApplicationController

  def show
    @customer = Customer.find(params[:id])
  end
  
  def leave
  end

  def out
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customers_params)
      flash[:success] = "ユーザ情報の更新に成功しました！"
      redirect_to customer_path(@customer.id)
    else
      render "edit"
    end
  end

private
    def customers_params
      params.require(:customer).permit(:email, :last_name, :first_name, :last_furigana, :first_furigana, :postal_code,:address,:telephone_number)
    end
end
