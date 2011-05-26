require File.expand_path('../boot', __FILE__)

require 'rails/all'

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

module CmsGallery
  class Application < Rails::Application
    
    require 'cms_gallery'
    config.encoding = "utf-8"
    
    config.filter_parameters += [:password]
    config.secret_token = 'e0fef4ab56c1cacd8845864fe2cb2a27f5caad72823419f87b2774785187090a654b83229bf9cef70ce475a83bfa561dbbaa2015788181ea837c456964c1e0f6'
  end
end
