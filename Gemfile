if ENV['NEXUS']
  source 'https://rubygems:8GQAJPEXooUd@nexus.ru/repository/rubygems/'
else
  source 'https://rubygems.org'
end

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

ruby '2.6.1'

gem 'active_link_to'
gem 'active_model_serializers'
gem 'auto-session-timeout'
gem 'bootstrap', '~> 4.1.3'
gem 'bootstrap4-datetime-picker-rails'
gem 'bootstrap4-kaminari-views'
gem 'clockwork'
gem 'configus'
gem 'devise'
gem 'draper'
gem 'enumerize'
gem 'kaminari'
gem 'pg', '~> 1.0'
gem 'rails-observers'
gem 'ransack'
gem 'redis-namespace'
gem 'state_machines-activerecord'

gem 'jquery-rails'
gem 'js-routes'
gem 'momentjs-rails'
gem 'rack-cors', require: 'rack/cors'

gem 'carrierwave' # , '~> 1.0'
gem 'carrierwave-base64'
gem 'carrierwave-postgresql', '0.2.0'
gem 'coffee-rails', '~> 4.2'
gem 'font-awesome-rails'
gem 'foundation_emails'
gem 'haml-rails'
gem 'hamlit'
gem 'jbuilder', '~> 2.5'
gem 'premailer-rails'
gem 'puma', '~> 3.11'
gem 'pundit'
gem 'rails', '~> 5.2.1'
gem 'redis', '< 4.2'
gem 'sass-rails', '~> 5.0'
gem 'simple_form'
gem 'sqlite3'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

gem 'axlsx', github: 'randym/axlsx', require: false
gem 'roo'
gem 'roo-xls'

gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'inky-rb', require: 'inky'
gem 'validates', github: 'kaize/validates'
gem 'virtus', '~> 1.0.0'

gem 'resque'
gem 'resque-retry'
gem 'resque-scheduler'

group :development, :test do
  gem 'awesome_print'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'letter_opener'
  gem 'rubocop', '0.58.2', require: false
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'factory_bot'
  gem 'fakeredis', github: 'guilleiguaran/fakeredis'
  gem 'minitest'
  gem 'minitest-reporters', require: false
  gem 'resque_unit'
  gem 'simplecov', require: false
  gem 'webmock'
end
