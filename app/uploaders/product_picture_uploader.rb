# encoding: utf-8
class ProductPictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  storage :file
 
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumb do
    process :resize_to_fit => [100,100]
  end

  version :feed do
    process :resize_to_fit => [500,500]
  end
  
  version :timeline do
    process :resize_and_pad => [460,590, "#FFFFFF"]
  end

  version :picture_300 do
    process :resize_and_pad => [150,300,"#FFFFFF"]
  end

  version :fancy do
    process :resize_and_pad => [200, 300, "#FFFFFF"]
  end
  
  def extension_white_list
    %w(jpg jpeg gif png)
  end
end