class Membership < ActiveRecord::Base
  attr_accessible :group_id, :user_id

  belongs_to :user
  belongs_to :group

  validates :group_id, presence: true
  validates :user_id, presence: true

  def self.get_group_stories(user)
    get_group_stories = "SELECT user_id FROM memberships
            WHERE user_id = :user_id"
    where("user_id IN (#{get_group_stories}) OR user_id = :user_id", 
          user_id: user.id)
  end
end
