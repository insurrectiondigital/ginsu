require 'rubygems'

class Ginsu
  module Runtime
    @ruby = {
      :platform => RUBY_PLATFORM,
      :engine   => RUBY_ENGINE,
      :version  => RUBY_VERSION,
      :revision => RUBY_REVISION,
      :patchlevel => RUBY_PATCHLEVEL,
      :release_date => RUBY_RELEASE_DATE,
      :engine_version => RUBY_ENGINE_VERSION,
      :invocation => Process.argv0,
      :env => ENV,

      #
      # The zlib key and its associated hash with keys/values is here so that
      # we can see, from the runtime perspective, what Ruby knows of zlib;
      # what version of the *ruby* library itself is there (Zlib::VERSION),
      # what version said library is relying on with the operating system
      # (Zlib::ZLIB_VERSION), and all the other major constants that Zlib
      # will rely on at runtime. This is going to be wicked useful if we
      # run into problems validating the checksum(s) of the source file
      # or any of its slices.
      #

      :zlib => {
        :VERSON => Zlib::VERSION,
        :ZLIB_VERSION => Zlib::ZLIB_VERSION,
        :BINARY => Zlib::BINARY,
        :ASCII => Zlib::ASCII,
        :TEXT => Zlib::TEXT,
        :UNKNOWN => Zlib::UNKNOWN,
        :NO_COMPRESSION => Zlib::NO_COMPRESSION,
        :BEST_SPEED => Zlib::BEST_SPEED,
        :BEST_COMPRESSION => Zlib::BEST_COMPRESSION,
        :DEFAULT_COMPRESSION => Zlib::DEFAULT_COMPRESSION,
        :FILTERED => Zlib::FILTERED,
        :HUFFMAN_ONLY => Zlib::HUFFMAN_ONLY,
        :RLE => Zlib::RLE,
        :FIXED => Zlib::FIXED,
        :DEFAULT_STRATEGY => Zlib::DEFAULT_STRATEGY,
        :MAX_WBITS => Zlib::MAX_WBITS,
        :DEF_MEM_LEVEL => Zlib::DEF_MEM_LEVEL,
        :MAX_MEM_LEVEL => Zlib::MAX_MEM_LEVEL,
        :NO_FLUSH => Zlib::NO_FLUSH,
        :SYNC_FLUSH => Zlib::SYNC_FLUSH,
        :FULL_FLUSH => Zlib::FULL_FLUSH,
        :FINISH => Zlib::FINISH,
        :OS_CODE => Zlib::OS_CODE,
        :OS_MSDOS => Zlib::OS_MSDOS,
        :OS_AMIGA => Zlib::OS_AMIGA,
        :OS_VMS => Zlib::OS_VMS,
        :OS_UNIX => Zlib::OS_UNIX,
        :OS_ATARI => Zlib::OS_ATARI,
        :OS_OS2 => Zlib::OS_OS2,
        :OS_MACOS => Zlib::OS_MACOS,
        :OS_TOPS20 => Zlib::OS_TOPS20,
        :OS_WIN32 => Zlib::OS_WIN32,
        :OS_VMCMS => Zlib::OS_VMCMS,
        :OS_ZSYSTEM => Zlib::OS_ZSYSTEM,
        :OS_CPM => Zlib::OS_CPM,
        :OS_QDOS => Zlib::OS_QDOS,
        :OS_RISCOS => Zlib::OS_RISCOS,
        :OS_UNKNOWN => Zlib::OS_UNKNOWN
      },

      :rubygems => {
        :ruby => Gem.ruby,
        :version => Gem::VERSION,
        :user_dir => Gem.user_dir,
        :user_home => Gem.user_home,
        :dir => Gem.dir,
        :win_platform => Gem.win_platform?,
        :config => {
          file: Gem.config_file,
          contents: File.read(Gem.config_file)
          # TODO: What if the above file has sensitive info in there? Like
          # API keys/tokens, usernames/passwords, or mom's secret chocolate
          # chip cookie recipe? SECURITAH!
        },
        :default_bindir => Gem.default_bindir,
        :bindir => Gem.bindir,
        :default_path => Gem.default_path,
        :post_install => Gem.post_install,
        :post_uninstall => Gem.post_uninstall,
        :loaded_specs => [] # TODO: Add these here and now instead of later
      },

      #
      # Ok, now we've answered the questions of the Ruby runtime and what
      # RubyGems itself thinks, so now let's see if Bundler is in the
      # equation at all and what's going on with it.
      #

      :bundler => {
        :version => "TODO"
      }
    }
  end
end
