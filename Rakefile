require File.expand_path('../config/application', __FILE__)
require 'rubygems'
require 'rake'

SofaGallery::Application.load_tasks

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name        = 'sofa_gallery'
    gem.homepage    = 'http://github.com/twg/sofa-gallery'
    gem.license     = 'MIT'
    gem.summary     = 'SofaGallery is an image gallery engine for Rails 3.1 apps (and ComfortableMexicanSofa)'
    gem.description = ''
    gem.email       = 'stephen@theworkinggroup.ca'
    gem.authors     = ['Oleg Khabarov', 'Stephen McLeod', 'The Working Group Inc.']
    gem.version     = File.read('VERSION').chomp
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end