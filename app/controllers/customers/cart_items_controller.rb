class Customers::CartItemsController < ApplicationController
	before_action :authenticate_customer!

  def index
    @items = current_customer.items
    @cart_items = current_customer.cart_items
	end

  def create
    @cart_item = current_customer.cart_items.build(cart_item_params)
    if CartItem.find_by(item_id: @cart_item.item_id).nil?
      @cart_item.save
      flash[:notice] = "商品をカートに追加しました。"
    else
      cart_item = CartItem.find_by(item_id: @cart_item.item_id)
      
      binding.pry
      
      cart_item.number += @cart_item.number.to_i
      
      binding.pry
      cart_item.save(cart_item_params)
      
      binding.pry
      
      flash[:notice] = "商品の数量を更新しました。"
    end
    redirect_to customer_cart_items_path(current_customer.id)
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.number = params[:cart_item][:number]
    if @cart_item.update(cart_item_params)
      flash[:notice] = "商品の数量を変更しました。"
      redirect_to customer_cart_items_path(current_customer.id)
    end
	end

  def destroy
    cart_item = CartItem.find_by(params[:id])
    if cart_item.destroy
      flash[:notice] = "カートの商品を削除しました。"
      redirect_to customer_cart_items_path(current_customer.id)
    end    
	end

  def all_destroy
    cart_items = CartItem.where(customer_id: current_customer.id)    
    if cart_items.destroy_all
      flash[:notice] = "カートを空にしました。"
      redirect_to customer_cart_items_path(current_customer.id)
    end
	end
  
  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :customer_id, :number)
  end
end
