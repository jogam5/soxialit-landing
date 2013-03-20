# encoding: utf-8

class BiografiaPictureUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick

  storage :file
  # storage :fog
  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :biografia do
    process :resize_and_pad => [750,250,"#240902"]
  end
end