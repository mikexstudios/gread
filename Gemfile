source 'https://rubygems.org'

gem 'rails', '3.2.13'
# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'
gem 'jquery-rails'

# Use same server for both development and production so that we can
# use foreman to automatically set variables in .env
gem 'puma', '~> 2.0.1'

group :development do
  gem 'annotate', '~> 2.5.0'
  
  # Place `debugger` somewhere in code to set breakpoint
  gem 'debugger', '~> 1.6.0'

  gem 'haml-rails', '~> 0.4.0' #for haml generators
end

group :development, :test do
  gem 'sqlite3', '~> 1.3.6'
  gem 'rspec-rails', '~> 2.13.2'
end

group :production do
  gem 'pg', '~> 0.15.1' #for heroku, PostgreSQL
  gem 'newrelic_rpm', '~> 3.6.2.96'
  
  # Scaling workers automatically on Heroku
  gem 'workless', '~> 1.1.2'
end

# Gems used only for assets and not required in production environments by
# default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end
#gem 'flatui-rails', '~> 0.0.4'
gem 'compass-rails', '~> 1.0.3'
gem 'bootstrap-sass', '~> 2.3.1.0'
gem 'font-awesome-sass-rails', '~> 3.0.2.2' #for better glyphs
gem 'bootstrap_file_input_rails', '~> 0.0.1' #bootstrap file input

#group :test do
#  gem 'capybara','~> 1.1.3' 
#  gem 'rspec-rails', '~> 2.11.4'
#end

gem 'haml', '~> 4.0.3'
gem 'high_voltage', '~> 1.2.1' #for static pages

gem 'will_paginate', '~> 3.0'
gem 'bootstrap-will_paginate', '~> 0.0.9' #output Twitter bootstrap style

gem 'devise', '~> 2.2.4'
gem 'rails_admin', '~> 0.4.8'

gem 'rack-superfeedr', '~> 0.1.0'
gem 'opml_saw', :git => 'git://github.com/feedbin/opml_saw.git'

#Background jobs
gem 'delayed_job', '~> 3.0.5'
gem 'delayed_job_active_record', '~> 0.4.4'

gem 'loofah', '~> 1.2.1' #sanitize html fragments

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'


