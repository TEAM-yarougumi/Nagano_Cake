class HomeController < ApplicationController
	before_action :authenticate_customer!

  def top
    @genres = Genre.where(status: true)
    @items = Item.find(1, 2, 3, 4)
  end

	def about
	end
end
