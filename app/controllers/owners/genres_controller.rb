class Owners::GenresController < ApplicationController
  before_action :authenticate_owner!

def index
     @genres = Genre.all 
end

def create
    @genre = Genre.new(genre_params) 
    if @genre.save
    redirect_to owners_genres_path
    end
end

def edit
  @genre = Genre.find(params[:id])
end

def update
  @genre = Genre.find(params[:id])
  @genre.update(genre_params)
  if @genre.save
  redirect_to owners_genres_path# 一覧画面へリダイレクト
  end

end


private
def genre_params
    params.permit(:name, :status)
  end
end