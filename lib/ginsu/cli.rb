class Ginsu
  class CLI
    def start
      puts "TODO: A simpler CLI with fewer dependencies"
    end
=begin
    include Commander::Methods
    def start
      program :name, 'ginsu'
      program :version, Ginsu::Meta::VERSION
      program :description, 'slices large files into more manageable ones'

      command :slice do |c|
        c.syntax = 'ginsu slice FILE --dest DEST --size SIZE'
        c.description = 'slices up FILE, saving to PATH in SIZE chunks'
        c.option '--dest PATH', String, 'Where to save the slices'
        c.option '--size SIZE', String, 'Slice size (ex "250M")'
        c.action do |args, options|
          Ginsu::Slice.run!({
            :infile => args[0], :dest => options.dest, :size => options.size
          })
        end
      end
      run!
    end
=end
  end
end
