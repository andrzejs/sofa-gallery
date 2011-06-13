# Loading engine only if this is not a standalone installation
unless defined? SofaGallery::Application
  require File.expand_path('sofa_gallery/engine', File.dirname(__FILE__))
end

require File.expand_path('sofa_gallery/configuration', File.dirname(__FILE__))

module SofaGallery
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