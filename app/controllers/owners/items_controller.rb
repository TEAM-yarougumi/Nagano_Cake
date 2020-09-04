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
end

def edit
end

def update
end


private
  def item_params
    params.require(:item).permit(:name, :content, :no_tax_price, :sale_status, :image ,:genre_id)
  end
end

