# Developer's Notes

Things I'm thinking of while doing other things; using this somewhat as a
scratchpad for obvious reasons and in hopes of sparking community discussion
around where my head's at with these ideas.

# TODO/Wishlist

+ Switch over to a less collision-prone hashing algorithm,
especially for small files (e.g. `ginsu slice ... 256k`) by using the
[rbnacl-libsodium](https://github.com/cryptosphere/rbnacl-libsodium) library
and then *package that with the distribution archive for each
platform* (e.g. OS X, Linux x86/x64, Windows x86/64)  

See https://github.com/cryptosphere/rbnacl/wiki/Windows-Installation for
Windows intallation instructions of the non-bundled gem (`rbnacl`, shipped
*without* embedded `libsodium`).

+ Set up `bundler-audit` to ensure that future releases don't ship vendored
gems that are known to have security vulnerabilities.
+ (big feature, probably never gonna happen) provide text-based terminal
interface, fully interactive, showing multiple "panes", intuitive menus
with both vim-like navigation and arrow-key navigation (as well as menus
accessible with function keys [e.g. `F1`, `F2`, etc.].) Would be hella slick
and very easy to use.
+ Progress bar support, showing progress via `STDOUT`.
+ CLI options for `--verbose` / `--quiet`. More detail vs. zero `STDOUT`.
+ Colored output - make it pretty and somewhat engaging to the user, even if
it *is* a text-based terminal application.
+ **Diagnostic Command** - run through the file slices according to
`manifest.json` and check that their *noted* checksums in the manifest are
actually, in fact, their *real* checksums on disk. Useful for detecting if
one of the slices was corrupted during download or something.
+ Add a warning for slice sizes under, oh let's say around 50MB: due to the
math involved in cryptographic hashing functions, the smaller the slice size,
the more probable it is that you'll run into hash collision, which makes two
very slightly different values appear the same, mathematically. Translation:
the smaller the slice, the less confident you can be that the checksum it
calculated and compares when running a diagnostic is actually correct. Less
able to detect corrupted files.
+ (big feature, but a needed one) **Encrypt ALL the things!** Allow user to
encrypt each slice as it's written to disk using a GPG key or basic SSH key.
  + WARN users: losing your private key means you can **never** get that data
    back, no matter what. It'll be gone forever.
  + DEPENDS on moving to `rbnacl` and having a working shippable binary and
    compiled lib on each operating system.
  + NEW KEY/VALUE IN MANIFEST: Will need to note the "naked" checksum of the
    slice as well as the checksum of that slice *after it's been encrypted*.
+ **Environment Variables** to control CLI options so you can invoke the
binary with a minimum of fuss and it knows what you want (e.g. for making it
scriptable. Not sure how it'll be used in a scripted way, but who cares? Tools
should *always* be scriptable!)
+ Configuration files: Look for a configuration file (`.ginsu_config`) in each
of `$PWD`, `$HOME/.config/`, `$HOME`. Use the first one found.
  + Configuration options may be something like:  
    + `manifest_format` (YAML, JSON, HJSON if I can find a good lib for that)
    + `public_key` path on localhost to a public key to use for encrypting the
      slices.
    + `encrypt_slices` true or false (false by default because performance)
    + `colorize_output` true or false (pretty `STDOUT` or not?)
    + `crypto_algorithm` tell `ginsu` which algorithm to use since it probably
      doesn't want to guess from your public key.
    + `crypto_bits` tell it also how many bits to use with that algorithm
      so that it can match up to your public key and (hopefully) not cause
      issues.
    + `checksum` What type of checksum to generate as the basis for the
      source file and each slice. Will list available options.
    + `logfile` Path to a local file to which you have write access.
    + `loglevel` DEBUG, INFO, WARN, FATAL etc. etc. How verbose you wanna be?
    + `slice_size` Specify a default slice size for everything. Used if one
      is *not* specified on the command line. (In other words, if you put it
      on the command line, this value will be ignored).
    + Other options related to backup when that feature ships
  + Ability to read configuration (`manifest`) as JSON, YAML or other markup
    languages (although I'm dead-set against XML. If you want XML, write your
    own! :stuck_out_tongue_winking_eye:
+ Backup directly to a remote location:
  + mounted filesystem via `rsync` if I can implement that directly, falling
    back to operating system calls otherwise;
    + Avoid calling shell commands *at all costs*. Not platform portable, and
      it's just an ugly hack, anyway.
  + cloud provider; first to be implemented will probably be [Amazon Cloud
    Drive](https://www.amazon.com/clouddrive/home) because that's what prompted
    me to build this tool in the first place. Might also open it up to other
    cloud storage options based on community involvement.
    + Upon upload of each slice, verify its checksum by calling the cloud
      provider's own API. If they don't support this, consider not bothering
      to build this feature for that specific service.
+ Directory Watch: given a specific directory, listen for filesystem
notifications from the operating system (PROBLEM: Can we get this feature with
Ruby running on Windows?) and upon receiving that notification (so, read that
as using an **evented** architecture...), scan the file for changes in size,
and if no size change, checksum. If either changed, automatically back it up
again, re-slicing if necessary/configured, and re-encrypting if appropriate.
+ Threads for all the things! Scan, slice, checksum, encrypt, write, copy
and/or upload each piece/task in its own thread. We're only reading data and
each thread will have access to the entirety of a given slice and *only* that
slice. Threads will help the overall process go faster in theory by reading,
per each thread, *only* the designated piece of data from the source file. Then
each thread can manage writing the slice, generating its checksum(s), etc. on
its own while other threads continue to do the same thing, each for their own
individual piece.
  + Ship the ruby/rubygems executable per platform as `rubinius` to get real
    threads and (hopefully?) much faster execution. Can't do `jruby` because
    then we'd have to ship, on top of `jruby` itself, an entire `java`
    interpreter, one per platform. ("Why is this tiny `hello-world` app almost
    half a gigabyte large?!") PROBLEM: Unknown if `rubinius` is still (or ever
    was, now that I think about it...) supported on Windows x64. Also, will
    `rubinius` and `rbnacl-libsodium` play nice together?

## Distribution

Thinking along the lines of `Bundler`, packaging the gems so there are no
additional downloads or risk of rubygems.org being down, a dependency
not versioned right, something being yanked, whatever. One package, everything
you need, **DONE**.

`bundle package --all --all-platforms`

[man bundle-package](http://bundler.io/v1.11/man/bundle-package.1.html)

### Traveling Ruby?

[Phusion](http://phusion.nl) has this thing they call "Traveling Ruby". The idea
is to distribute an appropriate Ruby runtime and other necessary environment +
tools for each major platform - Linux, Windows, OS X - and wrap that up with
your Ruby application. Might be a good way to give users a simple install
method. "Here, just `wget` this file and unzip it, then run `bin/ginsu`." Only
caveat is that I seriously doubt this will work on Windows, though it might
in Windows 10's *current* form, and I'd be even more optimistic after their
initiative to have Linux syscalls baked into their kernel has launched and been
thoroughly battle-tested and debugged.

**If NOT Traveling Ruby**, perhaps I can rig up some simple script to emulate
a `*nix` Ruby environment for the three major platforms, ship it myself.
*Maybe...*

### Launcher Script?

If running on OS X or Linux we can utilize `bash` as a lowest-common-denominator
to write a basic launcher script. But on Windows, `bash` isn't typically
available (at least until Microsoft ships their Windows 10 Linux syscalls
feature later in 2016; even then though, I wouldn't want to *count* on it).
Ergo, I'm wondering if it would be better to write the launcher script itself
in totally pure Ruby. Not sure how sane, maintainable or portable that is, or
if it'll be a total :facepalm: moment, but it's a thought.

Good idea that this guy puts in a thread/discussion on traveling ruby:
