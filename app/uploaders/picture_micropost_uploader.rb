# encoding: utf-8
class PictureMicropostUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  
  # Choose what kind of storage to use for this uploader:
  #storage :file
  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :feed do
    process :resize_to_fill => [120,120]
  end
  
  version :modal do
    process :resize_and_pad => [460,500,"white"]
  end
  
  version :index do
     process :resize_and_pad => [226, 255, "white"]
  end
  
end