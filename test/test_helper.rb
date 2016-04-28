#!/usr/bin/env ruby
#
# Start by requiring the simplecov gem. It absolutely *must* be the first thing
# you load in order to get accurate data out of it.
#
require 'simplecov' ; SimpleCov.start

#
# Modify $LOAD_PATH to pick up `ginsu/lib` since we don't necessarily want
# to run this against the *installed* version of the gem...
#
lib = File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
# require 'pry'; binding.pry
#
# Load ginsu, minitest/autorun, and any other test bootstrappy-things
# we might need later on down the line.
#
require 'minitest/autorun'
require 'minitest/pride'
require 'ginsu'
