class Photo < ActiveRecord::Base
  attr_accessible :file, :user_id, :original_photo_id, :timestamps, :hits, :recipient_id

  def self.get_top
  	order('updated_at DESC').limit(50).sample
  end

end
