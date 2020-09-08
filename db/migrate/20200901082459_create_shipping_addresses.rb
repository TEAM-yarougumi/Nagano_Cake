class CreateShippingAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :shipping_addresses do |t|
      t.timestamps
      t.references :customer, index: false, foreign_key: true
      t.string  :address_name
      t.string  :shipping_address
      t.string  :shipping_postal_code
    end
  end
end
