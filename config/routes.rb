Rails.application.routes.draw do
  
  namespace :gallery_admin, :path => SofaGallery.config.admin_route_prefix do
    resources :galleries do
      resources :photos do
        post  :reorder, :on => :collection
        get   :crop,    :on => :member
      end
    end
  end unless SofaGallery.config.admin_route_prefix.blank?
  
end
