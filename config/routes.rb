# if defined?(CmsGallery::Application)

Rails.application.routes.draw do
  namespace :cms_admin, :path => CmsGallery.config.admin_route_prefix do
    resources :galleries do
      resources :photos do
        collection do
          match :reorder
        end
      end
    end
  end unless CmsGallery.config.admin_route_prefix.blank?
  
  resources :photos,
    :only => [:show]
end
