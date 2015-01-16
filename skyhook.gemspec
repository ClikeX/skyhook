Gem::Specification.new do |s|
  s.name        = 'skyhook'
  s.version     = '0.3.0'
  s.date        = '2014-04-28'
  s.summary     = 'Steam API wrapper/library'
  s.description = 'A wrapper/library for the Steam web API'
  s.authors     = ['ClikeX']
  s.email       = 'w.s.van.der.meulen@gmail.com'

  s.files       = ['lib/skyhook.rb', 'lib/skyhook/configuration.rb', 'lib/skyhook/core.rb', 'lib/skyhook/game.rb', 'lib/skyhook/user.rb']

  s.homepage    =
    'http://rubygems.org/gems/skyhook'
  s.license       = 'MIT'

  s.required_ruby_version = '>= 2.1.2'

  s.post_install_message = 'Thank you for installing the Steampowered Skyhook for Ruby. Have fun!'

  s.add_runtime_dependency 'activesupport', '~> 4.0 '

  s.add_development_dependency 'dotenv', '~> 1.0', '>= 1.0.0'
  s.add_development_dependency 'rspec', '~> 2.0', '>= 2.0.0'
  s.add_development_dependency 'rake', '~> 10.0' ,'>= 10.0.0'
end
