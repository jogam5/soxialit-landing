class Notification < ActiveRecord::Base
  attr_accessible :follow, :lov_item, :lov_micropost, :lov_post, :user_id
  belongs_to :user
end
