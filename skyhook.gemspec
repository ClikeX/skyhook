# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'skyhook/version'

Gem::Specification.new do |s|
  s.name        = 'skyhook'
  s.version     = Skyhook::VERSION
  s.date        = '2014-04-28'
  s.summary     = 'Steam API wrapper/library'
  s.description = 'A wrapper/library for the Steam web API'

  s.authors     = ['ClikeX']
  s.email       = 'w.s.van.der.meulen@gmail.com'

  s.homepage    = 'http://rubygems.org/gems/skyhook'
  s.license       = 'MIT'


  s.post_install_message = 'Thank you for installing the Steampowered Skyhook for Ruby. Have fun!'

  s.files         = `git ls-files -z`.split("\x0")
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "bundler", "~> 1.7"
  s.add_development_dependency 'dotenv', '~> 1.0', '>= 1.0.0'
  s.add_development_dependency 'rspec', '~> 2.0', '>= 2.0.0'
  s.add_development_dependency 'rake', '~> 10.0' ,'>= 10.0.0'
  s.add_development_dependency 'vcr', '~> 2.9.3'
  s.add_development_dependency 'faraday', '~> 0.9.1'

  s.add_runtime_dependency 'activesupport', '~> 4.0 '

end
