source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.2'
gem 'mysql2'
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'rake'
gem 'bootstrap-sass'
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
  gem 'binding_of_caller'
  gem 'foreman', require: false
  gem 'awesome_print'
  gem 'listen'
    # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

end
