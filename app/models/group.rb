class Group < ActiveRecord::Base
  attr_accessible :description, :name, :picture

  has_many :memberships, :dependent => :destroy
  has_many :users, :through => :memberships
  has_many :microposts

  mount_uploader :picture, GroupPictureUploader

  def to_param
    name
  end

  def self.get_all_stories(group)
  	return group.microposts.order("created_at DESC")
  end

  def self.get_new_stories(group)
  	return group.microposts.order("created_at DESC").limit(4)
  end

  def self.get_top_stories
  end
end