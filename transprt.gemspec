# coding: utf-8
lib = File.expand_path('../lib', __FILE__)

Gem::Specification.new do |gem|
  gem.name = "transprt"
  gem.version = '0.1.2'
  gem.authors = ["ghn"]
  gem.email = ["ghugon@gmail.com"]
  gem.description = %q{Use the public transport Swiss API (open data).}
  gem.summary = "Swiss public transport."
  gem.homepage = 'https://github.com/ghn/transprt'
  gem.license = "MIT"

  gem.files = `git ls-files`.split($/)
  gem.executables = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency('rest-client', '~> 1.6.7')
  gem.add_dependency('json', '~> 1.8.0')
end
