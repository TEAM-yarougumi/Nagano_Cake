class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|

      t.timestamps
      t.references :customer, index: false, foreign_key: true
      t.integer :postage, default: 800
      t.integer :billing_amount
      t.integer :payment, default: 0
      t.string :address_name
      t.string :address
      t.string :postal_code
      t.integer :status, default: 0
    end
  end
end
