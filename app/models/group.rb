class Group < ActiveRecord::Base
  attr_accessible :description, :name, :picture, :user_id

  has_many :memberships, :dependent => :destroy
  has_many :users, :through => :memberships
  has_many :microposts

  VALID_GROUPNAME_REGEX = /^[a-zA-Z0-9_]*[a-zA-Z][a-zA-Z0-9_]*$/
  validates :name, presence: true,  format: { with: VALID_GROUPNAME_REGEX },
            uniqueness: { case_sensitive: false }

  before_save {  self.name.downcase! }

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

  def self.get_top_stories(group)
    return Micropost.find_with_reputation(:votes, :all, 
      {:conditions => ["microposts.group_id = ?", group.id], :order => 'votes desc'})
  end

  def self.get_trend_stories(group)
    days = Micropost.where('created_at >= ?', 4.day.ago).count
    return Micropost.find_with_reputation(:votes, :all, 
      {:conditions => ["microposts.group_id = ?", group.id], :order => 'created_at desc', :limit => days})
  end

  def self.get_stories(group)
    return Micropost.find_with_reputation(:votes, :all, 
      {:conditions => ["microposts.group_id = ?", group], :order => 'votes desc'})
  end
end
