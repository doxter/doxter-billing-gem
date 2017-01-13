# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'doctena_billing/version'

Gem::Specification.new do |spec|
  spec.name          = 'doctena_billing'
  spec.version       = DoctenaBilling::VERSION
  spec.authors       = ['Andre Rauschenbach']
  spec.email         = ['andre.rauschenbach@doctena.com']

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com' to prevent pushes to rubygems.org, or delete to allow pushes to any server."
  end

  spec.summary       = 'Gem to wrap billing.doctena.de API'
  spec.description   = 'Gem to wrap billing.doctena.de API'
  spec.homepage      = 'https://github.com/doxter/doctena-billing-gem'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.8'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'vcr', '~> 2.9'
  spec.add_development_dependency 'webmock', '~> 1.20'

  spec.add_dependency 'json',  '>=1.8'
  spec.add_dependency 'faraday', '>=0.9'
end
