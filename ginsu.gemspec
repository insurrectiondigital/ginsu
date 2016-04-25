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
  spec.post_install_message = Ginsu::Meta::POST_INSTALL_MESSAGE

  #
  # Required Ruby Version: This source code makes use of features only
  # available in Ruby 2.3.0 (specifically the tilde-based HEREDOC) strings
  #
  spec.required_ruby_version = '>= 2.3.0'

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "Delete this to push to rubygems.org"
  else
    raise "RubyGems 2.0 or newer is necessary. Upgrade to continue."
  end

  #
  # spec.files
  #
  # Assign the total list of files to this gem so that RubyGems knows its
  # inventory when it tries to bundle this thing up.
  # Reference:
  #   http://guides.rubygems.org/specification-reference/#files
  #
  spec.files  = Dir['lib/**/*.rb'] + Dir['bin/*'] + Dir['[A-Z]*']
  spec.files += Dir['test/**/*'] + Dir['readme.md']

  spec.bindir = "bin"

  spec.executables = Dir['bin/*']

  spec.require_paths = ['lib']

  #
  # Development-only dependencies; should not ship with the final
  # packaged gem.
  #
  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry", "~> 0.10.3"

  #
  # Runtime dependencies: these SHOULD ship with the packaged gem.
  #
  spec.add_runtime_dependency "toml-rb", "~> 0.3.14"
end
