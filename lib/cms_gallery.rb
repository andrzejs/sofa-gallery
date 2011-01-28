

module CmsGallery
  require 'cms_gallery/engine'
  ComfortableMexicanSofa::ViewHooks.add(:navigation, '/admin/navigation')
  ComfortableMexicanSofa::ViewHooks.add(:html_head, '/admin/html_head')
end