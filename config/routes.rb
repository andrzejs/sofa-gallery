Rails.application.routes.draw do
  
  namespace :gallery_admin, :path => SofaGallery.config.admin_route_prefix do
    resources :galleries do
      resources :photos do
        collection do
          match :reorder
        end
      end
    end
  end unless SofaGallery.config.admin_route_prefix.blank?
  
end
