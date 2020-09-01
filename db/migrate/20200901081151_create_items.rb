class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.integer :genre_id
      t.string :name
      t.text :content
      t.integer :no_tax_price
      t.string :image_id
      t.integer :sale_status, default: 0

      t.timestamps
    end
  end
end
