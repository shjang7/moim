source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'
gem 'rails', '~> 5.2.3'

gem 'bootstrap', '>= 4.3.1'
gem 'carrierwave', '1.2.2' # for image
gem 'devise', '~> 4.7', '>= 4.7.1'
gem 'faker', '2.1.0'
gem 'jquery-rails'
gem 'name_of_person'
gem 'omniauth-facebook'
gem 'will_paginate', '3.1.7'
gem 'will_paginate-bootstrap4', '~> 0.2.2'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.12'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'mini_magick', '~> 4.8' # for image
gem 'bootsnap', '>= 1.1.0', require: false
gem "aws-sdk-s3", require: false

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails'
  gem 'factory_bot_rails', require: false
  gem 'guard-rspec', require: false
  gem 'paperclip'
  gem 'rails-controller-testing', '~> 1.0.2'
  gem 'rspec-rails', '~> 3.8'
  gem 'simplecov', '~> 0.15.1', require: false
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara', '~> 2.15.4'
  gem 'database_cleaner'
  gem 'launchy', '~> 2.4.3'
  gem 'poltergeist'
  gem 'shoulda',                      '~> 3.5'
  gem 'shoulda-callback-matchers',    '~> 1.1', '>= 1.1.3'
end

group :production do
  gem 'fog', '1.42' # for image
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
