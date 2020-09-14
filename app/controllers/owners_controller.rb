class OwnersController < ApplicationController

	def top
		if Order.where(created_at: Time.zone.now.all_day).present?
			@data = Order.where(created_at: Time.zone.now.all_day).count
		end
	end

end
