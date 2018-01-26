Rails.application.routes.draw do
  root :to => 'stockists#index'
  resources :stockists
  get '/zipcode/:zip' => 'stockists#zip_lookup'

  get '/sync_orders', to: 'stockists#sync_orders'
  get '/total_orders', to: 'stockists#get_total_orders'

  get '/' => 'stockists#index', as: 'app'
  mount ShopifyApp::Engine, at: '/'


end
