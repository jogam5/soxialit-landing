# encoding: utf-8
class ProjectPictureUploader < CarrierWave::Uploader::Base
   include CarrierWave::RMagick
   
   storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  
  version :timeline do
     process :resize_to_limit => [770,0]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
   def extension_white_list
     %w(jpg jpeg gif png)
   end

end
