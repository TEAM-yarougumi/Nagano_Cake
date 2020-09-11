class ShippingAddress < ApplicationRecord
  belongs_to :customer 

  validates :address_name, presence: true
  validates :shipping_address, presence: true
  validates :shipping_postal_code, presence: true

  def registered_shipping_address
  	self.shipping_postal_code + "　" + self.shipping_address + "　" + self.address_name
  end
end
