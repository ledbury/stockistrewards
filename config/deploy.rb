set :application, 'stockistrewards'
set :branch, :master
set :repo_url, 'git@github.com:mauinewyork/stockistrewards'
set :keep_releases, 5
set :rvm_type, :user

set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets public/system solr vendor/bundle}
set :bundle_binstubs, nil

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :finishing, 'deploy:cleanup'
end

after 'deploy:publishing', 'deploy:restart'
