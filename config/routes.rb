Rails.application.routes.draw do
  root :to => 'stockists#index'
  resources :stockists

  get '/sync_orders', to: 'stockists#sync_orders'

  mount ShopifyApp::Engine, at: '/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
