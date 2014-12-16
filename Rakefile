require 'dotenv'
Dotenv.load

task default: %w[build]

task :build do
  sh 'rm *.gem'
  sh 'gem build skyhook.gemspec'
  sh 'sudo gem install *.gem'
end
