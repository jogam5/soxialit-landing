source 'https://rubygems.org'

gem 'rails', '3.2.8'

#Authentication and Authorizations
gem 'devise'
gem 'omniauth'
gem 'omniauth-facebook'
#gem 'oauth2'
gem 'cancan'
gem 'wicked'
gem 'hominid'
gem 'koala'

#Reputation
gem 'activerecord-reputation-system', require: 'reputation_system'

#Pictures
gem 'carrierwave'
gem 'rmagick'
gem 'fog'

#CSS
gem "bootstrap-sass", "~> 2.1.0.1"

#tags
gem 'acts-as-taggable-on'

#payment methods
gem 'mercadopago'
gem 'paypal-recurring'


#Improve files readability
gem 'annotate', '~> 2.4.1.beta'
#Improve performance in server
gem 'newrelic_rpm'

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
  #gem fileupload paintings
  gem 'jquery-fileupload-rails'
end

gem 'jquery-rails'
