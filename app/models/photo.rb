class Photo < ActiveRecord::Base
  attr_accessible :file, :user_id
end
