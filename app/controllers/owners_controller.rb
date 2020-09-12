class OwnersController < ApplicationController
 

 	def top
		@orders = Order.all
		if @orders.where([:created_at].to_s.match(/#{Date.today.to_s}.+/)).present?
			@data = @orders.where([:created_at].to_s.match(/#{Date.today.to_s}.+/)).count
		else
			@data = "注文なし！"
		end
 	end

end
