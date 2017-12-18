source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.2'
gem 'mysql2'
gem 'haml-rails'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'rake', '11.3.0'
gem 'bootstrap-sass', '~> 3.3.4'
gem 'therubyracer'
gem 'jquery-rails'
gem 'turbolinks'
gem 'rails_script', '~> 2.0'
gem 'shopify_app', github: 'Shopify/shopify_app'
gem 'shopify_api_extensions', github: 'mauinewyork/shopify_api_extensions'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :development do
  gem 'better_errors'
  gem 'puma'
  gem 'web-console', '~> 2.0'
  gem 'binding_of_caller'
  gem 'foreman', require: false
  gem 'awesome_print'

    # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # Capistrano
  gem 'capistrano', '~> 3.6.1'
  gem 'capistrano-bundler'
  gem 'capistrano-sidekiq' , github: 'seuros/capistrano-sidekiq'
  gem 'capistrano-rails', '~> 1.1.0'
  gem 'capistrano-rails-console'
  gem 'capistrano-rvm', '~> 0.1.1'
end
