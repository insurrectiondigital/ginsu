#
# Ginsu::Buffer
#
# Implementation of a simple, cheap, hacky "buffer" system that can be used
# to trap certain amounts of information in memory while copying a file segment.
#
# Let's say the user wants to use ginsu to slice a file that's 1TB in size,
# and they want segments of 5GB per slice. You can't rely on a machine having
# a whole whopping 5GB of space available, especially when swap comes into
# play - because it'll even worse abuse disk i/o - especially when you may
# be launching multiple threads to read the data at various positions. So
# for each segment ("slice"), you need a temporary buffer inside the program
# to read up to BUFFER_AMOUNT of bytes, flush to disk, then continue until
# the segment is done.
#
# Otherwise you'll just wind up cursing the gods, pumping your fist in the air
# with righteous indignation, and crying about it on hacker news.
#

require 'ginsu/bytes'

class Ginsu
  module Buffer
    extend Ginsu::Bytes

    attr_reader :buffer_size

    #
    # @buf = Ginsu::Buffer.new(buffer_size = (100 * 1024 * 1024))
    #
    # Creates a new Ginsu::Buffer object, **OPTIONALLY** passing in a size,
    # in bytes, represented as an integer, of how big you want that buffer's
    # max size to be. If you don't specify it, it'll **default to 100MB**.
    #
    def initialize(buffer_size=(100 * MEGABYTES))
      @buffer_size = buffer_size
    end

  end
end
