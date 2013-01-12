class Photo < ActiveRecord::Base
  attr_accessible :file, :user_id, :original_photo_id, :hits, :recipient_id
  validates :file,    presence: true, length: { maximum: 902660}
  validates :user_id, presence: true

  def self.get(request_user_id)
  	order('updated_at DESC').where('hits < 51 AND recipient_id IS NULL AND
  	 user_id != ?', request_user_id).limit(50).sample
  end

end
