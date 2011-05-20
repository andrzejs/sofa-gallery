require "comfortable_mexican_sofa"
require "cms_gallery"
require "rails"

module CmsGallery
  class Engine < Rails::Engine
    initializer 'cms_gallery.helper' do |app|
      ComfortableMexicanSofa::ViewHooks.add(:navigation, '/cms_admin/cms_gallery_navigation')
      ComfortableMexicanSofa::ViewHooks.add(:html_head, '/cms_admin/cms_gallery_html_head')
      
      ActionView::Base.send(:include, CmsGallery::ViewMethods)
    end
  end
end