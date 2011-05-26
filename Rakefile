require File.expand_path('../config/application', __FILE__)
require 'rubygems'
require 'rake'

CmsGallery::Application.load_tasks

# require 'rubygems'
# require 'bundler'
# begin
#   Bundler.setup(:default, :development)
# rescue Bundler::BundlerError => e
#   $stderr.puts e.message
#   $stderr.puts "Run `bundle install` to install missing gems"
#   exit e.status_code
# end
# require 'rake'
begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "cms_gallery"
    gem.homepage = "http://github.com/stephenmmcleod/cms_gallery"
    gem.license = "MIT"
    gem.summary = "CMS Gallery is an easy to use, super simple gallery plugin for Comfortable Mexican Sofa."
    gem.description = %Q{TODO: longer description of your gem}
    gem.email = "stephen@theworkinggroup.ca"
    gem.authors = ["Stephen McLeod"]
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end
# 
# Jeweler::RubygemsDotOrgTasks.new
# 
# require 'rake/testtask'
# Rake::TestTask.new(:test) do |test|
#   test.libs << 'lib' << 'test'
#   test.pattern = 'test/**/test_*.rb'
#   test.verbose = true
# end