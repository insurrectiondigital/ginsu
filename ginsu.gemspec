lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ginsu/meta'

#
# Main Gem Specification
#
Gem::Specification.new do |spec|
  spec.name                 = Ginsu::Meta::GEM_NAME
  spec.version              = Ginsu::Meta::VERSION
  spec.authors              = Ginsu::Meta::AUTHORS
  spec.email                = Ginsu::Meta::EMAILS
  spec.description          = Ginsu::Meta::DESCRIPTION
  spec.summary              = Ginsu::Meta::SUMMARY
  spec.homepage             = Ginsu::Meta::HOMEPAGE
  spec.license              = Ginsu::Meta::LICENSE
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
  spec.files  = Dir[
    'lib/**/*.rb',
    '[A-Z]*',
    'readme.md',
    'doc/**/*.md'
  ]

  #
  # spec.bindir and spec.executables tell Rubygems where your binaries are
  # and which executables to ship under that binaries directory.
  #
  spec.bindir = "bin"
  spec.executables = ['ginsu']

  #
  # What to append to $LOAD_PATH when the gem is required. This is
  # so the user can `require 'ginsu'` since ginsu's `lib` dir is
  # now in $LOAD_PATH.
  #
  spec.require_paths = ['lib']

  #
  # TODO: extensions << 'ext/compileme/extconf.rb'
  # Add extensions to the project that need to be natively compiled
  # upon installation. See the specification reference and Gem::Ext::Builder
  # for more details:
  #    http://guides.rubygems.org/specification-reference/#extensions
  #
  # spec.extensions << 'ext/buildme/extconf.rb'

  #
  # Extra rdoc files: if the user builds rdoc when installing the gem,
  # also include the following in addition to comments in the code.
  #
  # TODO: Create a doc/ directory with various markdown files, each of
  # which pertains to a specific subject or specific ginsu subcommand.
  # Then add those to this list as well.
  #
  spec.extra_rdoc_files = ['readme.md']

  #
  # requirements: informational for the user, not parsed or used
  # programmatically; tells the user what other requirements (outside of
  # Ruby/Rubygems) are needed to run this thing.
  #
  # spec.requirements << 'A lot of disk space :)'
  # spec.requirements << 'Some other requirement'
  # spec.requirements << 'Keep adding via the append operator'

  #
  # rdoc options: tell `rdoc` what options to use when building docs.
  # TODO: Investigate this in further detail. Example only below.
  # NOTE: Each argument - keys AND values - is supplied as an additional
  #       string via an append operator (:<<).
  #
  # spec.rdoc_options << '--title' << 'ginsu -- slice large files'\
  # << '--main' << 'readme.md' << '--line-numbers'

  #
  # Development-only dependencies; should not ship with the final
  # packaged gem.
  #
  spec.add_development_dependency "bundler", "~> 1.11"

  #
  # Runtime dependencies: these SHOULD ship with the packaged gem.
  #
  spec.add_runtime_dependency "toml-rb", "~> 0.3.14"
  spec.add_runtime_dependency "commander", "~> 4.4.0"
end
