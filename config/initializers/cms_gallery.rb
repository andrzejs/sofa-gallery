CmsGallery.configure do |config|
  
  # Just like CMS, photos are uploaded through Paperclip and can support filesystem or s3 storage.
  config.upload_photo_options = { :storage => :filesystem }
  
  # set the cms admin path if you have changed it for CMS
  config.admin_route_prefix = 'cms-admin'
  
end