module CmsGallery
  require 'cms_gallery/engine' if defined?(Rails)
  require 'cms_gallery/view_methods'
  require 'cms_gallery/configuration'
  
  class << self
    
    def configure
      yield configuration
    end
    
    def configuration
      @configuration ||= Configuration.new
    end
    alias :config :configuration
    
  end
end