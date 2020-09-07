class Owners::GenresController < ApplicationController
  # before_action :authenticate_owner! 一時的に無効化

  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genres_params) 
    if @genre.save
    redirect_to owners_genres_path
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

def update
  @genre = Genre.find(params[:id])
  @genre.update(genres_params)
  if @genre.save
  redirect_to owners_genres_path# 一覧画面へリダイレクト
  end
end

private
  def genres_params
    params.require(:genre).permit(:name, :status)
  end
end