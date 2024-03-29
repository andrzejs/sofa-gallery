require 'sofa_gallery'
require 'rails'
require 'paperclip'

module CmsGallery
  class Engine < Rails::Engine
    initializer 'sofa_gallery.helper' do |app|
      if defined?(ComfortableMexicanSofa)
        # applying configuraion
        SofaGallery.configure do |conf|
          conf.admin_route_prefix = ComfortableMexicanSofa.config.admin_route_prefix
          conf.upload_options     = ComfortableMexicanSofa.config.upload_file_options
          conf.admin_controller   = 'CmsAdmin::BaseController'
          conf.form_builder       = 'ComfortableMexicanSofa::FormBuilder'
        end
        # applying nav elements
        ComfortableMexicanSofa::ViewHooks.add(:navigation, '/sofa_gallery/admin/navigation')
        ComfortableMexicanSofa::ViewHooks.add(:html_head, '/sofa_gallery/admin/html_head')
      end
    end
  end
end