class Project < ActiveRecord::Base
  attr_accessible :description, :location, :name, :user_id, :picture
  attr_accessible :tag_list
  has_many :pictures, :dependent => :destroy
  has_many :activities, :as => :activitable, :dependent => :destroy
  has_many :comments, :as => :commentable, :dependent => :destroy
  belongs_to :user
  
  validates :description, :location, :name, :presence => { :message => "*dato requerido" }, :allow_blank => true
  attr_accessible :tag_list
  acts_as_taggable
  
end
   