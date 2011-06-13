require File.expand_path('../config/application', __FILE__)
require 'rubygems'
require 'rake'

SofaGallery::Application.load_tasks

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name        = 'sofa_gallery'
    gem.homepage    = 'http://github.com/twg/sofa_gallery'
    gem.license     = 'MIT'
    gem.summary     = 'SofaGallery is a super simple gallery plugin for ComfortableMexicanSofa'
    gem.description = ''
    gem.email       = 'stephen@theworkinggroup.ca'
    gem.authors     = ['Stephen McLeod', 'Oleg Khabarov', 'The Working Group Inc.']
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end