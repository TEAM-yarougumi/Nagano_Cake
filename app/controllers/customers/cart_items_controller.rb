class Customers::CartItemsController < ApplicationController
	before_action :authenticate_customer!

	def index
		@items = current_customer.cart_items.all
	end

  def create
    @cart_item = current_customer.cart_items.new(cart_item_params)
    @cart_item.item_id = params[:format]
    
    binding.pry
    
    if @cart_item.save
      flash[:notice] = "商品をカートに追加しました。"
      redirect_to customer_cart_items_path(current_customer.id)
    end
  end

	def update
	end

	def destroy
	end

	def all_destroy
  end
  
  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :customer_id, :number)
  end
end
