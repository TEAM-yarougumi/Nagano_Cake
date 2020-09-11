class OrderItem < ApplicationRecord
	belongs_to :order
	belongs_to :item
	validates :number, presence: true
	enum item_status: { not_start: 0, standby_making: 1, making: 2, making_finish: 3 }
	validates :item_status, inclusion: { in: OrderItem.item_statuses.keys }
end