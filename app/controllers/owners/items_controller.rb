class Owners::ItemsController < ApplicationController
 # before_action :authenticate_owner! 一時的に無効化

def new
  @item = Item.new
end

def create
  @item = Item.new(item_params)
  if @item.save
    redirect_to owners_items_index_owner_path 
  else 
    render  'new'
  end
end

def index_owner
  @item = Item.all
end

def show_owner
  @item = Item.find(params[:id])
  
end

def edit
  @item = Item.find(params[:id])
end

def update
  @item = Item.find(params[:id])
  @item.update(item_params)
  if @item.save
  redirect_to owners_items_index_owner_path# 一覧画面へリダイレクト
  end
end


private
  def item_params
    params.require(:item).permit(:name, :content, :no_tax_price, :sale_status, :image ,:genre_id)
  end
end

