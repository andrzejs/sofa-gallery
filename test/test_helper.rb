ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  
  fixtures :all
  include ActionDispatch::TestProcess
  
  def setup
    reset_config
  end
  
  # resetting default configuration
  def reset_config
    SofaGallery.configure do |config|
      config.admin_route_prefix = 'cms-admin'
    end
  end
  
end