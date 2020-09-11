class Order < ApplicationRecord
  belongs_to :customer, optional: true
  has_many :order_items, dependent: :destroy
  has_many :items, through: :order_items # 中間テーブルのアソシエーション定義

  validates :address, presence: true
  validates :address_name, presence: true
  validates :postal_code, presence: true

  enum payment: { credit_card: 0, bank_transfer: 1 }
  validates :payment, inclusion: { in: Order.payments.keys }

  enum status: { waiting_payment: 0, payment_confirm: 1, making: 2, ready_to_ship: 3, shipped: 4 }
  validates :status, inclusion: { in: Order.statuses.keys }
end
