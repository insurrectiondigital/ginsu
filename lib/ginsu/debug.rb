class Ginsu
  module Debug
    #
    # Looks for environment variable GINSU_DEBUG and if set and true, will load
    # up the `pry` gem so we can `binding.pry` wherever's clever.
    #
    if ENV.has_key?('GINSU_DEBUG') && ENV.fetch('GINSU_DEBUG') == true
      require 'rubygems'
      require 'pry'
      puts "Loaded pry gem since we found ENV['GINSU_DEBUG'] as true"
    end
  end
end
