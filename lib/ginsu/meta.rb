class Ginsu
  module Meta
    #
    # AUTHORS
    #
    # Array representing the author(s) of this tool. Used in `gemspec`.
    #
    AUTHORS = ["J. Austin Hughey"]

    #
    # EMAIL
    #
    # Array of each author's email address.
    #
    EMAILS = ["jah@insurrection.cc"]


    #
    # GEM_NAME
    #
    # String representing the name of this gem as it'll be referenced by
    # the RubyGems API. This is what goes in `gem install` and `require` for
    # example.
    #
    GEM_NAME = 'ginsu'

    #
    # VERSION sets the application's current version. Definitely trying to go
    # for a simplified [Semantic Versioning](http://semver.org) scheme here,
    # where A.B.C would be the pattern:
    #
    #   A -> Major release version; breaks backwards compatibility. New features
    #        and/or other major changes.
    #   B -> Minor release version; new features, but it *DOES NOT* break
    #        backwards compatibility. Everything that worked before should
    #        still work without any changes. If not, it's a bug.
    #   C -> Patch release version; bug fixes only. No new features, and
    #        everything is still backwards compatible.
    #
    # So for example:
    #
    #   0.0.1: pre-alpha/dev version. Say I find a bug, then I fix it.
    #   0.0.2: exact same as 0.0.1 except I fixed the bug. Yay!
    #   0.1.0: I got bored so I built a new feature! Fully backward-compatible.
    #   0.1.1: Found a bug with version 0.1.0 so I fixed it and pushed a fully
    #          backwards-compatible release.
    #   0.1.2: Found and fixed another bug. Everything that worked with 0.1.0,
    #          and 0.1.1 should still work without any modification with this
    #          new version. Just a bug fix.
    #   0.1.3: Found and fixed yet another bug! Works exactly the same as 0.1.0,
    #          0.1.1, and 0.1.2.
    #   1.0.0: FIRST OFFICIAL RELEASE, BABY! Since the MAJOR version number
    #          changed, **you should NOT expect this version to work like the
    #          previous ones you've used**. Major new features may have been
    #          implemented, the internals may have been rewritten, and/or other
    #          changes to workflow, the tool's capabilities, etc. may have
    #          happened so if something breaks, well, you knew it was a MAJOR
    #          release! You therefore have only yourself to blame. :)
    #
    VERSION = '0.0.1'

    #
    #
    # HOMEPAGE specifies where the repo lives on the wonderful wonderful web! :)
    #
    HOMEPAGE = "https://github.com/insurrectiondigital/ginsu"

    #
    # LICENSE tells the user what license this tool is distributed under. This
    # particular tool is open source and offered free of charge (and free as
    # in *freedom*) to the global internet community at large under the MIT
    # license. Basically, all I want is protection from bottom-feeding lawsuit
    # jockeys. Use at your own risk, etc. etc. which the MIT license seems
    # to do relatively well and not encumber others who want to use, fork or
    # improve the tool in some way.
    #
    LICENSE = 'MIT'

    #
    # LICENSE_URL specifies where you can read the license file online.
    # Purely for convenience reasons.
    #
    LICENSE_URL = "#{HOMEPAGE}/LICENSE"

    #
    # A written, short summary of what this tool does.
    #
    SUMMARY = <<~EOF
      Gigantic file? Slice it into pieces with `ginsu`! Or, join slices made \
      with `ginsu` to restore the original file to any path you specify. Makes \
      backups much easier due to network corruption and file size storage \
      limitations.
    EOF

    #
    # A much longer and more detailed description of how `ginsu` works.
    #
    DESCRIPTION = <<~EOF
      # Files too big? Slice 'em up with `ginsu`!

      Say you have a huge backup archive that you want to upload to some
      online storage provider:

      ```
      $ ls -Flach myarchive.tar.bz2
      -rw-r--r--@  1 you  staff   72G Apr 24 04:04 myarchive.tar.bz2
      ```

      Only problem: your storage provider might whine that they won't accept
      uploaded files larger than `N` gigabytes in size. Bummer! What's a
      hacker/sysadmin to do?

      ## Slice it up with `ginsu`!

      `ginsu` will take a given source file (say your 72GB .tar.bz2) and
      slice it up into smaller chunks, the size of which you specify.

      In a nutshell, you use it like this:

      ```
      $ ginsu slice myarchive.tar.bz2 /Volumes/Backups/myarchive 250MB
      ```

      Where:

      + `slice` tells `ginsu` that you want to cut up a file, as opposed to
      merging it back together (a "restore", of sorts);
      + `myarchive.tar.bz2` is the path on local filesystem to your huge
      unwieldly archive;
      + `/Volumes/Backups/myarchive` is where you want the sliced up files
      to be stored. **Directory will be created if it does not exist**, and
      under that directory will be a new directory named, in this example,
      `myarchive.tar.bz2.ginsu/`. It's basically the filename plus `.ginsu`.
      Under that directory is where all the various slices will be stored
      with filenames reflecting the original checksum of the original archive
      appended with their sequence in reassembly order and `.slice` so you
      know what kind of file it is.
      + `250MB` is how big you want each resulting slice to be. `ginsu` will
      do the math for you on how many slices you'll need and loop through
      cutting each one until the task is complete, updating you along the way.

      Restoring is also a piece of cake. For example:

      ```
      $ ginsu join /Volumes/Backups/myarchive/myarchive.tar.bz2.ginsu \
      $HOME/i/want/the/original/file/put/here
      ```

      This would bring together the various "slices" of your original file and
      put the resulting file, with its original filename, at the path specified.

      ## Interested yet?

      Yeah, I thought so. Head on over to the
      [ginsu GitHub repository](#{Ginsu::Meta::HOMEPAGE}) to read more about
      this tool.
    EOF

    #
    # POST_INSTALL_MESSAGE
    #
    # A message to be printed out after this gem is installed. Called from
    # `ginsu.gemspec`. Should explain to the user that the gem is intalled
    # and that they need only type the command `ginsu` and help will appear;
    # otherwise, visit Ginsu::Meta::HOMEPAGE for detailed documentation.
    #
    POST_INSTALL_MESSAGE = <<~EOF

      Thanks for installing ginsu!

      To get started, just type 'ginsu help' and hit enter. You'll be shown
      some simple help text to get you started.

      For detailed documentation, to report issues/bugs, and/or review the
      source code, visit ginsu's GitHub repository:

        #{Ginsu::Meta::HOMEPAGE}

      That's all you need to get started. Good luck!

    EOF

    #
    # DOCUMENTATION
    #
    # Tells the user where they can find more documentation for this gem.
    # This is usually going to be a link to an http url, but could also be
    # a location on disk. Not a parsed/programmatically-used value, purely
    # to be read (glanced at, really) by the user. But do keep it short.
    #
    DOCUMENTATION = <<~EOF
      More documentation and examples can be found online at our GitHub repo:
        https://github.com/insurrectiondigital/ginsu
    EOF
  end
end
