require File.expand_path('../test_helper', File.dirname(__FILE__))

class ConfigurationTest < ActiveSupport::TestCase
  
  def test_configuration_presense
    assert config = SofaGallery.configuration
    assert_equal nil,                         config.upload_options
    assert_equal 'cms-admin',                 config.admin_route_prefix
    assert_equal 'ApplicationController',     config.admin_controller
    assert_equal 'SofaGallery::FormBuilder',  config.form_builder
  end
  
  def test_initialization_overrides
    SofaGallery.configuration.admin_route_prefix = 'admin'
    assert_equal 'admin', SofaGallery.configuration.admin_route_prefix
  end
  
end