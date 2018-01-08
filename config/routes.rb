Rails.application.routes.draw do
  root :to => 'stockists#index'
  resources :stockists
  mount ShopifyApp::Engine, at: '/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
