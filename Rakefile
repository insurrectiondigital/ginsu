#!/usr/bin/env ruby

#
# Alter load path in development mode so we can easily obtain
# access to the ginsu library.
#
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bundler/gem_tasks'
require 'ginsu'
require 'pry'

task :default => :test

desc '[DEV] Opens a console via `pry` with the gem loaded'
task :console do
  Pry.start
end

desc '[DEV] test -- runs full test suite (see test/test_helper.rb)'
task :test do
  puts "TODO: Test system via minitest"
end
