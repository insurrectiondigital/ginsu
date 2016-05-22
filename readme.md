## Slice those giant files into more manageable pieces with...

# GINSU!

Say you have a file that's `40GB` in size. Maybe it's a compressed tarball of some stuff you've backed up. Uploading *that whole thing* is going to be a major pain in the posterior.

Enter *GINSU!*

This tool takes a given file and "slices" it into chunks of whatever file size you define using a slick and easy CLI. Each "slice" has its checksum computed and stored in an overall manifest so that any program that uploads these slices can check that checksum after upload to ensure that specific slice was uploaded correctly, and if not, well this way your program knows to re-try the operation.

| Fact | Details |
| :--- | ------: |
| Status | Early development (unreleased) |
| Author | [J. Austin Hughey](https://github.com/jaustinhughey) |
| License | [MIT](LICENSE) |

## Features

TODO

In a nutshell:

+ `ginsu slice`
+ `ginsu join`

And features I'd like to add in the future...

+ `ginsu backup` to backup to a configured backend (cloud, disk)
  + Need to define a "backend" concept; disk, network location, cloud integration (e.g. Amazon Cloud Files, S3, Dropbox, etc.)
  + Need to configure access to the remote location (if not local disk) in a secure manner that doesn't store keys/tokens/passwords as plain-text in the configuration, and doesn't require environment variables since any child process can read its parent process' `ENV`. Maybe tell the user to specify a file location containing the username, password, token, etc. and refuse to read it if permissions are anything other than `400` (owner:read-only everyone else: nothing)?
  + An optional `[--monitor]` option to see the progress as it happens in real time. Pair with a `[--verbose]` and/or `[--logfile=/path/to/my.log]` to get extreme detail and maybe put it in a logfile instead of `STDOUT`.
  + `ginsu backup --daemon` to have `ginsu` constantly monitor a given location and back it up according to its config (encrypting if configured, slicing as needed, etc.) whenever changes are detected; *requires some way to hook into filesystem events and monitoring that by long-running background process*
+ `ginsu help` for help info and/or man page
+ `ginsu encrypt` to use an asymmetric key pair to encrypt each slice
+ `ginsu config [--edit]` Without `--edit`, print current configuration to `STDOUT`; with the edit switch, open `$EDITOR` and allow user to edit configuration.
  + Ensure configuration is validated before save; cache invalid config somewhere so as not to trash user's work but also not to load it;
  + Put config in `ENV['GINSU_CONFIG']` if set, `$HOME/.config` if it exists as first fallback, `$HOME` as second fall back
  + For existing files, if the `.ginsu` directory in question has its own config file, let that override each setting one-by-one taking precedence over global config;
  + DOCUMENT DOCUMENT DOCUMENT. Each option needs comments above its actual definition. Defaults should always be mentioned, what each option does explained in plain language, and any warnings/caveats if an option conflicts with another or could cause stability/integrity/security issues, etc.
+ `ginsu validate ` (aliased as `ginsu check`) to make sure each slice has a valid checksum for real as it exists at the destination location
+ `ginsu status [dir] [--validate] [--verbose]` Given `dir`, get info on total size of all chunks, total number of chunks, total byte size for each (and in aggregate), and size on disk and print to `$STDOUT`. If given `--validate`, validate each slice/chunk during the status calculation, and if given `--verbose`, put an entry in `$STDOUT` for each slice instead of a summary of information.
+ A `--json` and `--toml` switch for all commands going to `STDOUT`. This makes it easy/possible to script against `ginsu` in the shell, although there should be discouraging notices around this telling users not to rely on shell scripts because the format of output can change, thus breaking their fragile sed/awk/grep-fu.
+ `ginsu server [dir] [--insecure]` given a valid `.ginsu` directory, serve up a simple API and web application/page over HTTP bound to `127.0.0.1` by default; if `--insecure` specified, bind to `0.0.0.0` with a big warning on the console (preferably in red blinking text) telling the user that anyone who can reach your computer directly over the network (including the global internet) can now view the details of your `.ginsu` file(s).
