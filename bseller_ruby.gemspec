# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bseller_ruby/version'

Gem::Specification.new do |spec|
  spec.name          = "bseller_ruby"
  spec.version       = BsellerRuby::VERSION
  spec.authors       = ["Wesley Conde"]
  spec.email         = ["kerponeis@gmail.com"]

  spec.summary       = %q{Bseller}
  spec.description   = %q{Bseller API}
  spec.homepage      = "https://github.com/wesleyskap/bseller_ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency             "savon"
  spec.add_dependency             "rest-client"
  spec.add_dependency             "gyoku", "~> 1.0"
  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.3"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "webmock"
end
