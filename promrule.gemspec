# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "promrule/version"

Gem::Specification.new do |spec|
  spec.name          = "promrule"
  spec.version       = Promrule::VERSION
  spec.authors       = ["Ryota Yoshikawa"]
  spec.email         = ["ryota-yoshikawa@cookpad.com"]

  spec.summary       = %q{Promrule is a tool to manage Prometheus alert/record rule.}
  spec.description   = %q{Promrule defines the state of Prometheus alert/record rule using DSL.}
  spec.homepage      = "https://github.com/rrreeeyyy/promrule"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "dslh", "~> 0.4.8"

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
