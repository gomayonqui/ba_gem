# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ba/version'

Gem::Specification.new do |spec|
  spec.name          = "ba"
  spec.version       = Ba::VERSION
  spec.authors       = ["Li Ellis Gallardo"]
  spec.email         = ["lellisga@gmail.com"]
  spec.description   = %q{BankBalance Gem is used to check your bank account balance}
  spec.summary       = %q{Checking your bank account is now much faster}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "thor"
  spec.add_dependency "mechanize"
  spec.add_dependency "highline"
  spec.add_dependency "fileutils"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"

  spec.post_install_message = "Important: You don't need any configuration file\n\n"
end
