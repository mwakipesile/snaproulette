class AddIndexToPhotos < ActiveRecord::Migration
  def change
  	add_index :photos, :updated_at
  end
end
