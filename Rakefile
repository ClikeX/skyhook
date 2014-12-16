require 'dotenv'
Dotenv.load

task default: %w[build]

task :build do
  sh 'gem build skyhook.gemspec'
  sh 'gem install *.gem'
end
