class SofaGallery::Configuration
  
  # Upload settings
  attr_accessor :upload_photo_options
  
  # Default url to access admin area is http://yourhost/cms-admin/ 
  # You can change 'cms-admin' to 'admin', for example.
  attr_accessor :admin_route_prefix
    
  # Configuration defaults
  def initialize
    @upload_photo_options   = { }
    @admin_route_prefix     = 'cms-admin'
  end
  
end
