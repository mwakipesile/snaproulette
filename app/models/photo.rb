class Photo < ActiveRecord::Base
  attr_accessible :file, :user_id, :original_photo_id, :timestamps, :hits, :recipient_id
  validates :file, presence:true

  def self.get_top
  	order('updated_at DESC').where('hits < 51 AND recipient_id IS NULL').limit(50).sample
  end

end
