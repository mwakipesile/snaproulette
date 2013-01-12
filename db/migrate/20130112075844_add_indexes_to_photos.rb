class AddIndexesToPhotos < ActiveRecord::Migration
  def change
  	add_column :photos, :original_photo_id, :integer
  	add_index :photos, :original_photo_id
  end
end
