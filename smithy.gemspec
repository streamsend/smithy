# -*- encoding: utf-8 -*-
require File.expand_path('../lib/smithy/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Chris O'Meara"]
  gem.email         = ["comeara@streamsend.com"]
  gem.description   = %q{An Inversion of Control (IoC) container for Ruby.}
  gem.summary       = %q{Smithy build objects for u.}
  gem.homepage      = "https://github.com/streamsend/smithy"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "smithy"
  gem.require_paths = ["lib"]
  gem.version       = Smithy::VERSION
  gem.add_development_dependency "rspec", "2.10.0"
end
