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

  def self.publish_project_facebook(project)
    @project = project
    @user = @project.user
      options = {
        :message => "Acabo de crear un proyecto en Soxialit.",
        :picture => @project.picture.to_s,
        :link => "http://soxialit.com/projects/#{@project.id}",
        :name => "#{@project.name} by #{@project.user.nickname}",
        :description => @project.description
      }
      @user.facebook.put_connections("me", "feed", options)
  end

  def self.publish_project_like_facebook(project)
    @project = project
    @user = current_user
      options = {
        :message => "Me gusto el siguiente proyecto en Soxialit.",
        :picture => @project.picture.to_s,
        :link => "http://soxialit.com/projects/#{@project.id}",
        :name => "#{@project.name} by #{@project.user.nickname}",
        :description => @project.description
      }
      @user.facebook.put_connections("me", "feed", options)
  end
  
end
   