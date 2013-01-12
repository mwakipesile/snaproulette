class AddIndexesToPhotos < ActiveRecord::Migration
  def change
  	add_index :photos, :recipient_id
  	add_index :photos, :original_photo_id
  	add_column :photos, :original_photo_id, :integer
  end
end
