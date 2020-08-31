class AddStatusToGenres < ActiveRecord::Migration[5.2]
  def change
    add_column :genres, :status, :boolean, default: false, null: false
  end
end
