# encoding: utf-8
class GroupPictureUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick

  storage :fog
  
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

end