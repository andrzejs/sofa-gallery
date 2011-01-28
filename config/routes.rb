VSVSVS::Application.routes.draw do

  namespace :admin, :path => 'admin' do
    resources :galleries do
      resources :photos,
        :collection => { :sort => :post }
    end
  end
  
end
