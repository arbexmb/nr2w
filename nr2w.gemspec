# frozen_string_literal: true

require_relative "lib/nr2w/version"

Gem::Specification.new do |spec|
  spec.name        = "nr2w"
  spec.version     = Nr2w::VERSION
  spec.summary     = "number 2 words"
  spec.description = "nr2w lets you convert number into words"
  spec.authors     = %w[arbexmb callmarx]
  spec.email       = "lucasarbexmb@gmail.com"
  spec.homepage    = "https://github.com/arbexmb/nr2w"
  spec.license     = "MIT"

  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
