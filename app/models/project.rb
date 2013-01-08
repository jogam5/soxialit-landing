class Project < ActiveRecord::Base
  attr_accessible :description, :location, :name, :user_id, :picture
  has_many :pictures, :dependent => :destroy
  belongs_to :user
  
  validates :description, :location, :name, :presence => { :message => "*dato requerido" }, :allow_blank => true
  
end
   