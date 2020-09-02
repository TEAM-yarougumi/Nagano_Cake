class Customers::CustomersController < ApplicationController

  def show
  end
  def leave
  end
  def out
  end
  def edit
  end
  def update
  end

 private
    def customers_params
      params.require(:customers).permit(:last_name, :first_name, :last_furigana, :first_furigana, :postal_code,:address,:telephone_number)
    end
end
