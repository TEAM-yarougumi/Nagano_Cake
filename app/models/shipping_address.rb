class ShippingAddress < ApplicationRecord
  belongs_to :customer 

  validates :address_name, presence: true
  validates :shipping_address, presence: true
  validates :shipping_postal_code, presence: true
end
