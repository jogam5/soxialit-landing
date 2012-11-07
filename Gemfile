source 'https://rubygems.org'

gem 'rails', '3.2.8'

#Authentication and Authorizations
gem 'devise'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'oauth2'
gem 'cancan'
gem 'wicked'
gem 'hominid'

#Reputation
gem 'activerecord-reputation-system', require: 'reputation_system'

#Pictures
gem 'carrierwave'
gem 'rmagick'
gem 'fog'

#CSS
gem "bootstrap-sass", "~> 2.1.0.1"

#Improve files readability
gem 'annotate', '~> 2.4.1.beta'

group :development, :test do
  gem 'sqlite3', '1.3.5'
  gem 'rspec-rails', '2.11.0'
end

group :production do
  gem 'pg', '0.12.2'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
