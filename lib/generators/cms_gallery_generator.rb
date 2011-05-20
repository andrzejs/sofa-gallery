class CmsGalleryGenerator < Rails::Generators::Base
  
  include Rails::Generators::Migration
  include Thor::Actions
  
  source_root File.expand_path('../../..', __FILE__)
  
  def generate_migration
    destination   = File.expand_path('db/migrate/01_create_cms_gallery.rb', self.destination_root)
    migration_dir = File.dirname(destination)
    destination   = self.class.migration_exists?(migration_dir, 'create_cms_gallery')
    
    if destination
      puts "\e[0m\e[31mFound existing create_cms_gallery.rb migration. Remove it if you want to regenerate.\e[0m"
    else
      migration_template 'db/migrate/01_create_cms_gallery.rb', 'db/migrate/create_cms_gallery.rb'
    end
  end
  
  def generate_initialization
    copy_file 'config/initializers/cms_gallery.rb', 'config/initializers/cms_gallery.rb'
  end
  
  def generate_public_assets
    directory 'public/stylesheets/cms_gallery', 'public/stylesheets/cms_gallery'
    directory 'public/javascripts/cms_gallery', 'public/javascripts/cms_gallery'
  end
  
  def show_readme
    readme 'lib/generators/README'
  end
  
  def self.next_migration_number(dirname)
    orm = Rails.configuration.generators.options[:rails][:orm]
    require "rails/generators/#{orm}"
    "#{orm.to_s.camelize}::Generators::Base".constantize.next_migration_number(dirname)
  end
  
end