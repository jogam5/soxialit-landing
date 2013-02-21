source 'https://rubygems.org'

gem 'rails', '3.2.11'

#Authentication and Authorizations
gem 'devise'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'cancan'
gem 'wicked'
gem 'hominid'
gem 'koala'

#gem cache
gem 'dalli'

#gem to delay processes in Facebook
gem 'delayed_job_active_record'
gem "workless", "~> 1.1.1"

#gem copy text_field entry into clipboard
gem 'zclip-rails'

#Reputation
gem 'activerecord-reputation-system', require: 'reputation_system'

#Pictures
gem 'carrierwave'
gem 'rmagick'
gem 'fog'
gem "fastimage", "~> 1.2.13"

#CSS
gem "bootstrap-sass", "~> 2.1.0.1"

#tags
gem 'acts-as-taggable-on'

#payment methods
gem 'mercadopago'
gem 'paypal-recurring'

#estafeta_scrapping
gem "net-ssh"
gem 'nokogiri'

#facebook_metatags
gem 'metamagic'

#metasearch
gem "meta_search"

#Improve files readability
gem 'annotate', '~> 2.4.1.beta'
#Improve performance in server
gem 'newrelic_rpm'
#Redirect 
gem 'rack-rewrite'
#Embedly
gem 'embedly'

#Online validation
gem 'client_side_validations'

#Pagination
gem 'will_paginate'

group :development, :test do
  gem 'sqlite3', '1.3.5'
  gem 'rspec-rails', '2.11.0'
  gem 'thin'
  gem 'quiet_assets'
end

group :production do
  gem 'pg', '0.12.2'
  gem 'thin'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  # gem 'therubyracer', :platforms => :ruby
  gem 'uglifier', '>= 1.0.3'
  #gem fileupload paintings
  gem 'jquery-fileupload-rails'
  gem "twitter-bootstrap-rails"
end

gem 'jquery-rails'