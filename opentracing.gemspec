# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'opentracing/version'

Gem::Specification.new do |spec|
  spec.name          = "opentracing"
  spec.version       = OpenTracing::VERSION
  spec.authors       = ["ngauthier", "bcronin"]
  spec.email         = ["support@lightstep.com"]

  spec.summary       = %q{OpenTracing Ruby Platform API}
  spec.homepage      = "https://github.com/opentracing/opentracing-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "simplecov-console"
end
