class Customers::ItemsController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    if request.query_string == ""
      # 商品一覧
      @genres = Genre.where(status: true)
      @items = Item.page(params[:page]).reverse_order
      @title = "商品"
    else
      # ジャンル一覧
      @genres = Genre.where(status: true)
      genre = Genre.find(params[:genre_nav])
      items = Item.where(genre_id: genre.id)
      @items = items.page(params[:page]).reverse_order
      @title = genre.name
    end
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

  def search
  end

end
