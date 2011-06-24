Rails.application.routes.draw do
  
  get '/galleries/:id', :to => 'sofa_gallery/galleries#show', :as => 'sofa_galleries'
  
  namespace :gallery_admin, :path => SofaGallery.config.admin_route_prefix do
    resources :galleries do
      resources :photos do
        put :reorder, :on => :collection
        get :crop,    :on => :member
      end
    end
  end unless SofaGallery.config.admin_route_prefix.blank?
  
end
