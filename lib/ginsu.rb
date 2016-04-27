require 'ginsu/logging'
require 'ginsu/runtime'
require 'ginsu/buffer'
require 'ginsu/meta'
require 'ginsu/cli'
require 'ginsu/os'

class Ginsu
  #
  # Ginsu::Bytes
  #
  # Define the size of each type of byte (GB, MB, KB, etc.) for convenience.
  # We now have Ginsu::MEGABYTES, Ginsu::GIGABYTE, etc.
  #
  # TODO: Extend a base class or add global constants for these values instead,
  # making extending classes and such less needed and access to those things
  # much, much easier.
  #
  extend Ginsu::Bytes

  #
  # VERSION
  #
  # Import the constant VERSION from Ginsu::Meta so that
  # other tools expecting VERSION to be present don't break.
  #
  VERSION = Ginsu::Meta::VERSION

  #
  # Basic idea here is to do this as follows:
  #
  # Before starting, find out the number of processor cores on the system.
  # That's the max number of threads allowed under the program. So if you
  # have 4 cores, you get 4 threads, max. Don't want to melt the user's
  # computer here, or make their machine go insane with disk i/o.
  #
  # Also figure out how much memory they have to create an internal temporary
  # buffer of an appropriate size. I'm thinking something on the order of
  # 25mb per operating thread should be fine in most cases but it would be
  # nice to dynamically calculate the value based on the user's available
  # memory instead, so it can scale + be super duper fast for teh serverz
  # in da cloudz.
  #
  # We also need the md5sum, crc32 sum or adler32 sum of the original source
  # file itself (specific algorithm TBD). This is so we know, for sure, once
  # the file is re-assembled that it's not corrupted.
  #
  # Finally, find out the total number of allowed open file handles on the
  # operating system and each time data gets written out, make sure you're
  # not going to push it into overdrive and hit that ceiling (and if you do,
  # rescue it and retry that write operation until it succeeds).
  #
  # 1. Require all the needed stuff and bootstrap the application
  # 2. Check for necessary CLI params:
  #   a) source file: exists, is readable?
  #   b) dest location: exists, is writable?
  #   c) slice size: matches format of '1G' or `250mb` etc.? No decimals or
  #      other weird funky shit?
  #   d) does source file exceed user's desired slice size? No? Exit, no point
  # 3. Calculate where each separate "copy-this-much" and "write out" task
  #    should start and stop, to the byte
  # 4. Write out the directory structure with mainfest.json and readme.md
  # 5. Create an empty array and then for each slice, add its start/end byte
  #    positions to that array. [ {start: 0, end: 1024}, {start: 1025, end:...}]
  # 6. While maintaining only N running threads total and without exceeding
  #    ~50% of total number of file handles allowed:
  #    a) Read from START_BYTE to MAXBUFFER bytes from the file, starting at
  #       START_POS and up to MAXBUFFER bytes, or END_POS, whichever comes first
  #    b) Write in append-only mode to the specific slice file in the
  #       designated directory;
  #    c) When each total slice has finished being streamed to its file pointer,
  #       run an IO::flush operation to force it to the disk
  #    d) Close the file pointer on both SOURCE and DEST;
  #    e) Re-open a new file pointer on DEST after it's flushed and calculate
  #       its [md5/adler32/crc32] checksum
  #    f) Append this information to the overall status on the user's screen,
  #       or their log, and be ready to write it out to `manifest.json`.
  # 7. When finished with all slices:
  #    a) Close read file pointer(s) if any on SOURCE
  #    b) Write out the manifest.json file
  #    c) Geneate the readme.md file with nice formatting showing the user
  #       the structure of the directory, byte size of each file, checksum of
  #       each file, etc. - basically what's in manifest.json, but more user
  #       friendly and with information about what generated that file (ginsu)
  #    d) Flush STDOUT to make sure their screen, if watching/logging, is up
  #       to date;
  #    e) Write out a final summary to STDOUT and any logs that might be
  #       implemented in future.
  # 8. Exit status zero (0).
  #
end
