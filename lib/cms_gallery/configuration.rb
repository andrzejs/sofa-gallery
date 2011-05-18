class CmsGallery::Configuration
  # Upload settings
  attr_accessor :upload_photo_options
    
  # Configuration defaults
  def initialize
    @upload_photo_options  = {}
  end
  
end
