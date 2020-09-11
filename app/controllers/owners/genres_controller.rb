class Owners::GenresController < ApplicationController
  # before_action :authenticate_owner!

  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      flash[:notice] = "ジャンル登録完了しました！"
      redirect_to owners_genres_path
    else
      flash[:notice] = "更新に失敗しました。入力を確認してください。"
      @genre = Genre.all
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
    flash[:notice] = "カテゴリーを更新しました"
    redirect_to owners_genres_path# 一覧画面へリダイレクト
  else
    render :edit

  end
end

  private
  def genre_params
    params.require(:genre).permit(:name, :status)
  end
end