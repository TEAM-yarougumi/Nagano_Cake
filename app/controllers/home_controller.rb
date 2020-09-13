class HomeController < ApplicationController
  def top
    @genres = Genre.where(status: true)
    @items = Item.find(1, 2, 3, 4)
  end
  
	def about
	end
end