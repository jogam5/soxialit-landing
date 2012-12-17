class Painting < ActiveRecord::Base
  attr_accessible :image, :name, :product_id
  mount_uploader :image, ProductPictureUploader
  
  belongs_to :product
  
  validate :picture_size_validation, :if => "image?"  
  
  def picture_size_validation
      errors[:image] << "la imagen debe ser menor a 2MB, intenta con otra imagen" if image.size > 2.megabytes
  end
  
end
