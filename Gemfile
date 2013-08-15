source 'https://rubygems.org'
ruby '1.9.3'
gem 'rails', '3.2.13'
group :assets do
  #gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  #gem 'bootstrap-sass'
end
gem 'jquery-rails'
gem 'devise'
gem 'gmaps4rails'
gem 'figaro'
gem 'haml-rails'
gem 'mongoid'
gem 'omniauth-twitter'
gem "omniauth", "~> 1.1.1"
gem "omniauth-facebook"
gem 'nifty-generators'
gem 'will_paginate'
gem 'will_paginate_mongoid'
gem 'cancan'
gem 'simple_form'
gem "therubyracer"
gem "less-rails"
gem 'twitter-bootstrap-rails'
gem 'bootstrap-datetimepicker-rails'
#gem 'geocoder', :git => 'git://github.com/alexreisner/geocoder.git', :branch => 'fix_mongoid_nearbys'
group :development do
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_19, :rbx]
  gem 'html2haml'
  gem 'hub', :require=>nil
  gem 'quiet_assets'

end
group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'debugger'
end
group :test do
  gem 'capybara'
  gem 'cucumber-rails', :require=>false
  gem 'database_cleaner'
  gem 'email_spec'
  gem 'launchy'
  gem 'mongoid-rspec'
end

gem "mocha", :group => :test