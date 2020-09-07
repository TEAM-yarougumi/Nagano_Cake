class Item < ApplicationRecord
	belongs_to :genre
	validates :name, presence: true
	validates :content, presence: true
	validates :no_tax_price, presence: true
	
	enum sale_status: { unvalied: 0, valied: 1}
	validates :sale_status, inclusion: { in: Item.sale_statuses.keys }
  
	attachment :image
end
