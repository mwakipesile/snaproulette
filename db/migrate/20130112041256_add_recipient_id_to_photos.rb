class AddRecipientIdToPhotos < ActiveRecord::Migration
  def change
  	add_column :photos, :recipient_id, :string
  end
end
