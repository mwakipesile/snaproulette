class AddHitsToPhotos < ActiveRecord::Migration
  def up
  	add_column :photos, :hits, :integer, :default => 0
  end
  def down
  	remove_column :photos, :hits, :integer
  end
end
