class Owners::GenresController < ApplicationController

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
end

def update
end


private
def genre_params
    params.permit(:name, :status)
  end
end