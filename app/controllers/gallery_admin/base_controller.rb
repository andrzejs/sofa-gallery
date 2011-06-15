class GalleryAdmin::BaseController < SofaGallery.config.admin_controller.to_s.constantize
  layout 'gallery_admin/application'
end