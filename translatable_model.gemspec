# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'translatable_model/version'

Gem::Specification.new do |spec|
  spec.name          = "translatable_model"
  spec.version       = TranslatableModel::VERSION
  spec.authors       = ["Haziman Hashim"]
  spec.email         = ["haziman@abh.my"]
  spec.summary       = "Making every model has another column for translation"
  spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "configurability", "~> 2.2.1"
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
