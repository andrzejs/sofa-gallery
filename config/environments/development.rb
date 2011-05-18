HOST_NAME   = 'test.local'
SITE_URL    = "http://#{HOST_NAME}"
ADMIN_EMAIL = 'admin@site.com'

CmsGallery::Application.configure do
  config.cache_classes                          = false
  config.whiny_nils                             = true
  config.consider_all_requests_local            = true
  config.action_view.debug_rjs                  = true
  config.action_controller.perform_caching      = false
  config.action_mailer.raise_delivery_errors    = false
  config.active_support.deprecation             = :log
  config.action_dispatch.best_standards_support = :builtin
  config.action_mailer.default_url_options = { :host => HOST_NAME }
end

