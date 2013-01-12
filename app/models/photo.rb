class Photo < ActiveRecord::Base
  attr_accessible :file, :user_id, :rank, :timestamps
end
