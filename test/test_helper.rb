ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  # Cms needs a site to work. Can't put this in the fixture unfortunately
  def create_site(hostname = 'vsvsvs.local')
    CmsSite.create!(:label => 'Test Site', :hostname => hostname)
  end

end

class ActionController::TestCase
  
  setup :create_site, :http_auth
  
  def http_auth
    auth_string = "#{ComfortableMexicanSofa::HttpAuth.username}:#{ComfortableMexicanSofa::HttpAuth.password}"
    request.env['HTTP_AUTHORIZATION'] = "Basic #{Base64.encode64(auth_string)}"
  end
  
  def setup
    request.host = 'vsvsvs.local'
  end
  
end
