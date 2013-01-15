class Picture < ActiveRecord::Base
  attr_accessible :image, :project_id, :position 
  belongs_to :project
  
  mount_uploader :image, ProjectPictureUploader
  
  validate :picture_size_validation, :if => "image?", :on => :create
   
  def picture_size_validation
     errors[:image] << "la imagen debe ser menor a 2MB, intenta con otra imagen" if image.size > 2.megabytes
  end
  
end
