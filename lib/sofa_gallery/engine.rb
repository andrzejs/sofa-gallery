require "comfortable_mexican_sofa" if defined?(ComfortableMexicanSofa)
require "cms_gallery"
require "rails"

module CmsGallery
  class Engine < Rails::Engine
    initializer 'cms_gallery.helper' do |app|
      if defined?(ComfortableMexicanSofa)
        ComfortableMexicanSofa::ViewHooks.add(:navigation, '/cms_admin/cms_gallery_navigation')
        ComfortableMexicanSofa::ViewHooks.add(:html_head, '/cms_admin/cms_gallery_html_head')
      end
      
      ActionView::Base.send(:include, CmsGallery::ViewMethods)
    end
  end
end