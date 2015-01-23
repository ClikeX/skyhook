require './lib/skyhook'
require 'dotenv'

Dotenv.load
Skyhook::Configuration.configure api_key: ENV['API_KEY']

Dir.glob('tasks/*.rake').each { |r| import r }

task default: %w[build_and_install]

task :build do
  sh 'gem build skyhook.gemspec'
  sh 'gem install *.gem'
end

task :build_and_install do
  sh 'gem build skyhook.gemspec'
  sh 'gem install *.gem'
  sh 'rm *.gem'
end
