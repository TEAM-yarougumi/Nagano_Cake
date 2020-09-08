class CreateCartItems < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_items do |t|
      t.references :item, index: false, foreign_key: true
      t.references :customer, index: false, foreign_key: true
      t.integer :number

      t.timestamps
    end
  end
end
