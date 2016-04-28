#!/usr/bin/env ruby
require_relative 'test_helper.rb'

class TestGinsuMain < Minitest::Test
  def setup
    # TODO
  end

  def test_has_version
    assert Ginsu::VERSION
  end
end
