class CmsGallery::Configuration
  # Upload settings
  attr_accessor :upload_photo_options, :admin_route_prefix
    
  # Configuration defaults
  def initialize
    @upload_photo_options  = {}
    @admin_route_prefix = 'cms-admin'
  end
  
end
