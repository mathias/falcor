# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'falcor/version'

Gem::Specification.new do |spec|
  spec.name          = "falcor"
  spec.version       = Falcor::VERSION
  spec.authors       = ["Matt Gauger"]
  spec.email         = ["matt.gauger@gmail.com"]
  spec.description   = "Quickly build example data"
  spec.summary       = "Quickly build example data"
  spec.homepage      = "https://github.com/mathias/falcor"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'activesupport',  '~> 4.0.0'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-debugger"
end
