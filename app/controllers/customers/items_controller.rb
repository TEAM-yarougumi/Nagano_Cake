class Customers::ItemsController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    if params[:genre_nav].blank?
      # 商品一覧
      @genres = Genre.where(status: true)
      @items_count = Item.all.count
      @items = Item.page(params[:page]).per(8)
      @title = "商品"
    else
      # ジャンル一覧
      @genres = Genre.where(status: true)
      @genre = Genre.find(params[:genre_nav])
      @items_count = Item.where(genre_id: params[:genre_nav]).count
      @items = Item.where(genre_id: @genre.id).page(params[:page]).per(8)
      @title = @genre.name
    end
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @genres = Genre.where(status: true)
  end

end
