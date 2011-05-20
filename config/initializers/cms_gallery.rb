CmsGallery.configure do |config|
  # Just like CMS, photos are uploaded through Paperclip and can support filesystem or s3 storage.
  config.upload_photo_options = { :storage => :filesystem }
end