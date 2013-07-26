require './lib/ck_fu/version'

Gem::Specification.new do |spec|
  spec.name = 'ck_fu'
  spec.version = CkFu::VERSION
  spec.authors = ['Randy Schmidt']
  spec.email = ['me@r38y.com']
  spec.summary = 'Adds a bar to kep distinguish between environments.'
  spec.homepage = ''

  spec.files = `git ls-files`.split($/)
  spec.executables = spec.files.grep(%r{^bin/}) { |file| File.basename(file) }
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport', '>= 3.2'

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 2.13'
end
