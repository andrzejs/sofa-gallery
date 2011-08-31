Rails.application.routes.draw do
  
  namespace :sofa_gallery, :path => '' do
    
    resources :galleries, :only => :show
    
    namespace :admin, :path => SofaGallery.config.admin_route_prefix do
      resources :galleries do
        resources :photos do
          put :reorder, :on => :collection
          get :crop,    :on => :member
        end
      end
    end unless SofaGallery.config.admin_route_prefix.blank?
  end
  
end
