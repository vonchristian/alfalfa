source 'https://rubygems.org'

ruby '2.3.0'

gem 'rails'
gem 'draper'
gem 'jquery-ui-rails'
gem 'public_activity'
gem 'bootstrap-sass'
gem "font-awesome-rails"
gem 'paperclip', '~> 4.3.2'
gem 'pg_search'
gem 'prawn'
gem 'prawn-table'
gem 'devise'
gem 'pundit'
gem 'simple_form'
gem 'momentjs-rails', '>= 2.9.0'
gem 'datetimepicker-rails', github: 'zpaulovics/datetimepicker-rails', branch: 'master', submodules: true
gem 'sass-rails'
gem "bootstrap-datepicker-rails"
gem 'autoprefixer-rails'
gem 'uglifier'
gem 'delayed_job'
gem 'delayed_job_active_record'
gem 'jquery-rails'
gem "coffee-rails"
gem "select2-rails"
gem 'mina-puma', :require => false

group :production do
  gem 'pg',  group: :development
  gem 'rails_12factor'
  gem 'puma', group: :development
end

group :development, :test do
gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'guard-rspec'
  gem 'spring-commands-rspec'
  gem 'vcr'
end

group :development do
  gem 'rake'
  gem 'spring'
end

group :test do
  gem 'shoulda-matchers', '~> 3.1'
  gem 'database_cleaner'
  gem 'faker'
  gem 'webmock'
  gem 'selenium-webdriver'
  # gem 'capybara-webkit'
end


###########code optimization and cleanup####
  gem 'traceroute', group: :development
  # gem 'rack-mini-profiler'
  # gem 'bullet', group: :development
  gem 'brakeman', :require => false, group: :development
  gem "rails_best_practices", group: :development
############################################
