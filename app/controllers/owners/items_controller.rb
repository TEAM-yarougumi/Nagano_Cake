class Owners::ItemsController < ApplicationController
 # before_action :authenticate_owner! 一時的に無効化

def new
  @item = Item.new
  @genres = Genre.where(status: true)
end

def create
  @item = Item.new(items_params)
  if @item.save
    flash[:notice] = "商品登録完了しました！"
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
  @item.update(items_params)
  if @item.save
  flash[:notice] = "商品登録更新しました！"
  redirect_to owners_items_index_owner_path# 一覧画面へリダイレクト
  
end
end


private
  def items_params
    params.require(:item).permit(:name, :content, :no_tax_price, :sale_status, :image ,:genre_id)
  end
end

