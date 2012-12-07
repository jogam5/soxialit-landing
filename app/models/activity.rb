class Activity < ActiveRecord::Base
  attr_accessible :activitable_id, :activitable_type, :user_id
  belongs_to :activitable, :polymorphic => true
  belongs_to :user
  has_many :comments, :as => :commentable, :dependent => :destroy

  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", 
          user_id: user.id)
  end
end