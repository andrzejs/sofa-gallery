module SofaGallery
  class Configuration
    
    # Paperclip upload settings for photos
    attr_accessor :upload_options
  
    # Default url to access admin area is http://yourhost/cms-admin/ 
    # You can change 'cms-admin' to 'admin', for example.
    attr_accessor :admin_route_prefix
    
    # Controller that should be used for admin area
    attr_accessor :admin_controller
    
    # Form builder
    attr_accessor :form_builder
    
    # Configuration defaults
    def initialize
      @upload_photo_options   = { }
      @admin_route_prefix     = 'admin'
      @admin_controller       = 'ApplicationController'
      @form_builder           = 'SofaGallery::FormBuilder'
    end
    
  end
end