class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.integer :order_id
      t.integer :items_id
      t.integer :number
      t.integer :item_status, default: 0
      t.integer :buy_price

      t.timestamps
    end
  end
end
