class Picture < ActiveRecord::Base
  attr_accessible :image, :project_id, :position 
  belongs_to :project
  
  mount_uploader :image, ProjectPictureUploader
  
end
