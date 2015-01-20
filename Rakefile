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
