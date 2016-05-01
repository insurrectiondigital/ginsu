require 'bigdecimal'
class Ginsu
  module Bytes
    KILOBYTE          = KILOBYTES = (1024.0)
    MEGABYTE          = MEGABYTES = (KILOBYTE * 1024.0)
    GIGABYTE          = GIGABYTES = (MEGABYTE * 1024.0)
    BYTE_MEASUREMENTS = {
      :g => GIGABYTE,
      :m => MEGABYTE,
      :k => KILOBYTE
    }

    def self.parse(b)
      #
      # TODO: Check that the format passed in is actually right
      #
      mdata = b.match(/(\d+)([k|m|g])/i)
      return ((mdata[1]).to_f * BYTE_MEASUREMENTS[mdata[2].to_sym].to_f).to_f
    end
  end
end
