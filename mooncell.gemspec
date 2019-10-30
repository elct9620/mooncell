# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mooncell/version'

Gem::Specification.new do |spec|
  spec.name          = 'mooncell'
  spec.version       = Mooncell::VERSION
  spec.authors       = ['蒼時弦也']
  spec.email         = ['contact@frost.tw']

  spec.summary       = 'The Domain Driven Design Online Game Server'
  spec.description   = 'The Domain Driven Design Online Game Server'
  spec.homepage      = 'https://github.com/elct9620/mooncell'

  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`
      .split("\x0")
      .reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.17'
  spec.add_development_dependency 'bundler-audit', '~> 0.6.1'
  spec.add_development_dependency 'overcommit', '~> 0.51.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.76.0'

  spec.add_dependency 'dotenv', '~> 2.7.5'
  spec.add_dependency 'faye-websocket', '~> 0.10.9'
  spec.add_dependency 'puma', '~> 4.2.1'
  spec.add_dependency 'rack', '~> 2.0'
  spec.add_dependency 'sequel', '~> 5.25.0'
end
