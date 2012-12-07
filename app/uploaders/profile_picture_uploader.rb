class ProfilePictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :profile do
    process :resize_to_fit => [100,100]
  end

  version :thumb_profile do
    process :resize_and_pad => [50,50,"#240902"]
  end
  
end