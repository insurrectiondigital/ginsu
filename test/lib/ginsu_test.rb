require_relative '../test_helper'

#
# GinsuTest
#
# Base tests for the Ginsu root class. This is JUST for the stuff
# under Ginsu itself, not its included modules; they'll be in their own
# files with names corresponding to their entries under the lib/ directory.
#
class GinsuTest < Minitest::Test
  def test_base_attributes
    @ginsu = Ginsu.new("slice", "/path/to/file")
    
  end
end
