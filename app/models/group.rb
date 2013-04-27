class Group < ActiveRecord::Base
  attr_accessible :description, :name, :picture

  has_many :memberships, :dependent => :destroy
  has_many :users, :through => :memberships

  mount_uploader :picture, GroupPictureUploader

  def to_param
    name
  end
end