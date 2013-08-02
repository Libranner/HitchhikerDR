# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Hitchhiker::Application.initialize!
require 'will_paginate'
require 'will_paginate/array'

