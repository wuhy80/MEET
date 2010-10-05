class Friendship < ActiveRecord::Base
  belongs_to :user      
  belongs_to :friend, :class_name => 'User'    

end

# == Schema Information
#
# Table name: friendships
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  friend_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

