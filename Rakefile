require "bundler/gem_tasks"
require './lib/skyhook'
require 'dotenv'

Dotenv.load
Skyhook::Configuration.configure api_key: ENV['API_KEY'], debug: true

Dir.glob('tasks/*.rake').each { |r| import r }
