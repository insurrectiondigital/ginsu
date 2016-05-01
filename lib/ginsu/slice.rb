class Ginsu
  class Slice
    #
    # ginsu slice <...>
    #
    # The core of where ginsu's slice command does its thing.
    #
    def self.run!(opts)
      #
      # TODO: Run a preflight checklist of opts to be sure we have valid
      # source file, destination path, and byte size.
      #

      #
      # Set localized variables that expand out pathnames, parse the
      # byte size argument, etc.
      #
      infile  = File.absolute_path(opts[:infile])
      outfile = File.absolute_path(opts[:dest])

      #
      # Assume the files are there and otherwise everything's fine. Check the
      # size parameter and parse it.
      #
      size = Ginsu::Bytes.parse(opts[:size])

      #
      # How many slices do we need at the given file size?
      #
      filesize = File.new(infile).size
      needed_slices = (filesize.to_f / size.to_f).ceil

      #
      # This array holds our slice objects
      #
      slices = []

      #
      # Create the needed slice objects and add them to the threads array.
      #
      bytepos = 0
      while bytepos < filesize do
        read_from = bytepos
        if size.to_f + bytepos > filesize
          read_to = filesize.to_f
        else
          read_to = size.to_f + bytepos
        end
        slices << Ginsu::Slice.new(first_byte: read_from, last_byte: read_to)
        bytepos += size.to_f
      end
require 'pry'; binding.pry
      #
      # For each slice, read the designated byte positions and write out the
      # outfile.
      #
      # slices.each do |slice|
      #   bytes = File.read(infile, slice.first_byte)
      # end

    end

    #
    # prefilight - the
  end
end

#
# --------------------------
#

class Ginsu
  class Slice
    attr_reader :first_byte, :last_byte
    def initialize(opts)
      @first_byte = opts[:first_byte]
      @last_byte  = opts[:last_byte]
    end
  end
end
