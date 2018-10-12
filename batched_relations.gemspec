# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'batched_relations/version'

Gem::Specification.new do |spec|
  spec.name          = "batched_relations"
  spec.version       = BatchedRelations::VERSION
  spec.authors       = ["James Coleman"]
  spec.email         = ["jtc331@gmail.com"]
  spec.summary       = %q{Performantly batch ActiveRecord relation queries}
  spec.description   = %q{}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "appraisal", "~> 2.1"
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "pg"

  spec.add_dependency "activerecord", ">= 5.0", "< 5.2"
  spec.add_dependency "activesupport", ">= 5.0", "< 5.2"
end
