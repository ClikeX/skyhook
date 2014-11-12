Gem::Specification.new do |s|
  s.name        = 'skyhook'
  s.version     = '0.0.0'
  s.date        = '2014-04-28'
  s.summary     = "Steam API wrapper/library"
  s.description = "A wrapper/library for the Steam web API"
  s.authors     = ["ClikeX"]
  s.email       = 'w.s.van.der.meulen@gmail.com'
  s.files       = ["lib/skyhook.rb", "lib/skyhook/core.rb", "lib/skyhook/game.rb", "lib/skyhook/user.rb"]
  s.homepage    =
    'http://rubygems.org/gems/skyhook'
  s.license       = 'MIT'
  s.required_ruby_version = '~> 1.9.3'
  s.requirements << 'ActiveSupport'
  s.post_install_message = "Thank you for installing the Steampowered Skyhook for Ruby. Have fun!"
end
