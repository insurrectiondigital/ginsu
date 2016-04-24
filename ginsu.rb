#!/usr/bin/env ruby

#
# ginsu.rb
#
# Entry point for ginsu file separation and merging system.
# Official repo: github.com/insurrectiondigital/ginsu
# License: MIT (see file LICENSE at project root for details)
# Copyright 2016 Insurrection Digital, LLC
#

require 'rubygems'
require 'fileutils'
require 'json'
require 'zlib'

# Starting the app is as easy as:
require_relative 'lib/ginsu.rb'
Ginsu.new
