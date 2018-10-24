lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'opentracing/version'

Gem::Specification.new do |spec|
  spec.name          = 'opentracing'
  spec.version       = OpenTracing::VERSION
  spec.authors       = %w[ngauthier bcronin bensigelman]
  spec.email         = ['info@opentracing.io']

  spec.summary       = 'OpenTracing Ruby Platform API'
  spec.homepage      = 'https://github.com/opentracing/opentracing-ruby'
  spec.license       = 'Apache-2.0'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rubocop', '~> 0.54.0'
  spec.add_development_dependency 'simplecov', '~> 0.16.0'
  spec.add_development_dependency 'simplecov-console', '~> 0.4.0'
end
