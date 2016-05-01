require 'bundler/gem_tasks'
require 'rake/testtask'
require 'fileutils'
require 'webrick'

task :default => :test

#
# rake test
#
# Runs all tests.
#
desc 'Runs all tests under test/{lib, functional, cli, misc}/*.rb'
task :test do
  Rake::TestTask.new do |t|
    t.test_files = (
      FileList['test/lib/*.rb']        +
      FileList['test/functional/*.rb'] +
      FileList['test/cli/*.rb']        +
      FileList['test/misc/*.rb']
    )
  end
end

#
# rake test:*
#   Namespace for test-related rake tasks.
#
namespace :test do
  desc "Example: rake test:generate name=clicommand path='test/cli'"
  task :generate do
    name = ENV['name']
    path = ENV['path']

    outfile = File.join(
      File.expand_path('../', __FILE__),
      path,
      "#{name}_test.rb"
    )

    if File.exist?(outfile)
      puts "ERROR: This file already exists: #{outfile}"
      exit(1)
    end

    tmpl = <<~EOF
      require_relative '../test_helper'
      class Test#{name.capitalize} < Minitest::Test
        def test_example
          skip 'FIXME: I am an auto-generated test!'
        end
      end
    EOF

    File.open(outfile, 'w') do |f|
      f.puts tmpl
    end
  end
end

desc 'Launches a simple webserver so you can view coverage tests easily.'
task :'serve-coverage' do
  docroot = File.expand_path '../coverage', __FILE__
  unless File.exist?(docroot)
    puts "Directory for simplecov output doesn't exist: ./coverage"
    exit!(1)
  end

  server = WEBrick::HTTPServer.new :Port => 31337, :DocumentRoot => docroot
  trap 'INT' do
    server.shutdown
  end

  $stdout.puts <<~EOF
    View coverage information by pointing your browser at:
      http://localhost:31337

    When finished, use CTRL+C to exit this process.

  EOF
  server.start
end
