server 'mauivideo.co', user: 'sdeploy', roles: %w{app web db}
set :deploy_to, '/var/www/mauivideo.co'
set :rails_env, :staging
