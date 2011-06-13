# encoding: utf-8
class Sofa::ImageUploader < CarrierWave::Uploader::Base
  
  include CarrierWave::MiniMagick
  
  storage :file
  
  # Storage directory
  def store_dir
    "uploads/photos/#{model.id}"
  end
  
  version :thumb do
    process :resize_to_fill => [200, 200]
  end
  
  def extension_white_list
    %w(jpg jpeg gif png)
  end
  
end