class Order < ApplicationRecord
  belongs_to :customer 
  has_many :order_items, dependent: :destroy

  validates :address, presence: true
  validates :address_name, presence: true
  validates :postal_code, presence: true
      
  enum payment: { credit_card: 0, bank_transfer: 1 }
  validates :payment, inclusion: { in: Order.payments.keys }

  enum status: { 入金待ち: 0, 入金確認: 1, 製作中: 2, 発送準備中: 3, 発送済: 4 }
end
