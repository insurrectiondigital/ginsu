require 'etc'

class Ginsu
  module OS
    #
    # Ginsu::OS.page_size
    #
    # Used internally; page size reported by the operating system.
    # Returns an integer representing the size of a memory page in
    # the running operating system. Represented as raw bytes (not kb, etc)
    #
    def self.page_size
      Etc.sysconf(Etc::SC_PAGE_SIZE)
    end

    #
    # Ginsu::OS.num_pages
    #
    # Total number of pages as reported by the operating system;
    # Returns an integer representing Etc::SC_PHYS_PAGES.
    #
    def self.num_pages
      Etc.sysconf(Etc::SC_PHYS_PAGES)
    end

    #
    # Ginsu::OS.total_mem
    #
    # Returns integer of total available memory on the computer, in bytes.
    #
    def self.total_mem
      #
      # So far in research, the best I can find on how to calculate
      # this is to use the Etc module and ask it for SC_PAGE_SIZE
      # and multiply that time SC_PHYS_PAGES, then calculate into
      # units of 1024 for kb/mb/gb.
      #
      # FIXME: Is there a better way to get this data?
      #
      page_size.to_f * num_pages.to_f
    end

    #
    # Ginsu::OS.cur_process_memory
    #
    # Returns an integer showing the current total memory usage in bytes
    # of the currently-running process. Useful for knowing if we're about
    # to hit a huge memory ceiling or something.
    #
    def self.cur_process_memory
      #
      # On OS X, you have to write direct C code to interface with the kernel.
      # There's no simple interface like Linux' procfs to get this information.
      # Sooooo...we *have* to shell out. I hate shelling out because it's a
      # wicked ugly hack, but it's all we can realistically do here...
      #

      if File.exist?("/bin/ps")
        return `ps -o rss= -p #{Process.pid}`.to_i
      end

      #
      # If there's no /bin/ps, who knows what we're running on? In this
      # case, just report zero. It's impossible for this program to take
      # zero memory, so this is a way for anything relying on this method
      # to know that we can't reliably get this from the operating system,
      # so it needs to take alternative steps to work around things.
      #
      return 0

    end

    #
    # Ginsu::OS.max_files
    #
    # Returns maximum number of open file handles on the given platform.
    # This is (on OS X, at least) equivalent to `ulimit -n`. Should work
    # the same on Linux.
    #
    # TODO: Test this on Windows under MRI and RBX; see if it actually
    # returns a useful chunk of data or not, and if not, add some code to
    # prevent it from exploding.
    #
    def self.max_files
      Process.getrlimit(:NOFILE)[0]
    end

    #
    # Ginsu::OS.max_procs
    #
    # Returns the maximum number of processes the executing user can have
    # running.
    #
    def self.max_procs
      Process.getrlimit(:NPROC)[0]
    end

    #
    # Ginsu::OS.num_cores
    #
    # Returns: integer representing number of CPU cores available according to
    # the operating system. On modern Intel CPUs, this appears to be cores * 2
    # because of "hyperthreading".
    #
    # FIXME: Does this work on Windows *without* the Linux syscalls in kernel?
    # If not, is there a fair alternative? If so, implement it; if not, try to
    # catch the error with a reasonable fallback (say 1 because we know it has
    # at least that much, otherwise how's this running?)
    #
    def self.num_cores
      Etc.nprocessors
    end
  end
end
