class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.references :genre, index: false, foreign_key: true
      t.string :name
      t.text :content
      t.integer :no_tax_price
      t.string :image_id
      t.integer :sale_status, default: 0

      t.timestamps
    end
  end
end
