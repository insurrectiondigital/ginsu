require_relative 'test_helper'

class TestGinsuOS < Minitest::Test

  def test_stats_methods
    #
    # The following runs through several values that should always be
    # above zero. Comparing them as such allows us to validate that not
    # only are they present, and not only are they above zero, but that
    # they're also numeric, as opposed to strings.
    #
    # Calling Object#methods(false) tells it to only include the stuff
    # I actually defined on that object for its methods. It's like saying
    # "exclude Class.methods and Object.methods, I don't care about those,
    # just the stuff -I- wrote!"
    #
    Ginsu::OS.methods(false).each do |m|
      assert (Ginsu::OS.send(m) > 0)
    end
  end
end
