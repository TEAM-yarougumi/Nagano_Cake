class Item < ApplicationRecord
	belongs_to :genre
	has_many :cart_items, dependent: :destroy
	has_many :customers, through: :cart_items # 中間テーブルのアソシエーション定義
	has_many :order_items, dependent: :destroy
	has_many :orders, through: :order_items # 中間テーブルのアソシエーション定義

	validates :name, presence: true
	validates :content, presence: true
	validates :no_tax_price, presence: true
	
	enum sale_status: { unavailable: 0, available: 1}
	validates :sale_status, inclusion: { in: Item.sale_statuses.keys }
  
	attachment :image
end
