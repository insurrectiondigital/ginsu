# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ginsu/meta' # includes version info

Gem::Specification.new do |spec|
  spec.name             =       Ginsu::Meta::GEM_NAME
  spec.version          =       Ginsu::Meta::VERSION
  spec.authors          =       Ginsu::Meta::AUTHORS
  spec.email            =       Ginsu::Meta::EMAILS
  spec.description      =       Ginsu::Meta::DESCRIPTION
  spec.summary          =       Ginsu::Meta::SUMMARY
  spec.homepage         =       Ginsu::Meta::HOMEPAGE
  spec.license          =       Ginsu::Meta::LICENSE

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "Delete this to push to rubygems.org"
  else
    raise "RubyGems 2.0 or newer is necessary. Upgrade to continue."
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir = "exe"

  spec.executables = spec.files.grep(%r{^exe/}) do |f|
    File.basename(f)
  end

  spec.require_paths = ['lib']

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry", "~> 0.10.3"
end
