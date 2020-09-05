class Item < ApplicationRecord
	belongs_to :genre
	validates :name, presence: true
	validates :content, presence: true
	validates :no_tax_price, presence: true
	
	enum sale_status: { 販売中止: 0, 販売中: 1}

	attachment :image
end
