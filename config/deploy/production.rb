server 'stockistrewards.com', user: 'sdeploy', roles: %w{app web db}
set :deploy_to, '/var/www/stockistrewards.com'
set :rails_env, :production
