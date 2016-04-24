# Have you ever been told your file upload is too big?

So one day I was trying to use Amazon's existing desktop application to upload
a roughly ~45GB bzip2 compressed tarball of a backup to their "unlimited"
cloud storage offering. Only *after* the desktop application (which is so bad
that I'd literally be causing you harm by linking you to it, which is why
I haven't done so) uploaded all ~45GB of data did it tell me, *after* several
hours of waiting on it, **that my uploaded file was too large.**

I thought of trying to build a whole new desktop client or CLI to handle
uploading stuff to their "infinite" cloud storage offering. Then I realized
that this problem isn't unique to Amazon Cloud Drive -- it could conceivably
be a problem for all kinds of upload destinations, especially for large backups.

That's why I hacked together this tool, which I call `ginsu`.

# ginsu - chopping up your hella big files

The idea is that, just as a master Japanese chef might use a *ginsu* knife to
very precisely slice up something while preparing a meal, so too will we very
precisely slice up a given large file into several small ones.

## (But `ginsu` also merges them back together.)

Don't worry that this is a useless tool of theory, only half baked in that it
cuts things up and then hopes you figure out a way to put it all back together
again. Nope! `ginsu` will also allow you to merge all the separated files
back together easy-peasy.

## Status: Development (Incomplete)

| Fact | Value |
| ---- | ----- |
| Original Author | [J. Austin Hughey](https://github.com/jaustinhughey) |
| License | MIT (See [`LICENSE`](LICENSE) file for details) |
| Platforms | Built/Used on Mac OS X. No other platform tested so far. |
| Production-ready? | **HELL NO!** |

## How do I use it?

Here are some examples of the CLI. **Note that while in development, all these
examples, the syntax, the "DSL", etc. are _subject to change_**. Nothing's
finalized as of this writing.

### Slice up a file: `ginsu slice`

Let's say you have a 50GB `.tar.bz2` file on your local disk. You want to "chop"
that sucker into however many files are needed such that each file is no bigger
than 500MB. Here's how you'd invoke `ginsu` to do that:

#### Syntax

```
ginsu slice <big file> <path to put data out to> <slice size>
```

`ginsu` takes one large file and "chops" it up into small ones. To make sure
that each small file is available relative to all the others in a given set,
`ginsu` **will output the "sliced" file into a specific subdirectory**. If you
don't specify one, the command will output to `$PWD/<filename>-ginsu`.

#### Parameters

+ `<big file>` The path to any given file on your machine that the program
can read. So, for example, `/Volumes/USBStick/homemovie.mov`. It doesn't matter
how big the file itself is (within reason...), nor do you need to specify any
other information or details. The file itself (and its parent directory) only
need read access from the user who's invoking the command - that's it.
+ `<path to put data out to>` This is where you want the slices of that file
to wind up when everything's said and done. **This will create a new directory
at the given location**. That new directory will be named based on the filename
with the extension `.ginsu` added to the end. So for example, if your file name
is `homemovie.mov`, the directory would be named `homemovie.mov.ginsu` and that
directory would be located under the path you specify in this parameter. **Your
executing user absolutely DOES need read and write access to this path on your
system.** For more information about what the `.ginsu` directory contains,
see the section below.
+ `<slice size>` This is a number and a label, for example `1G` for one
gigabyte. *We measure based on increments of __1024__, not 1000*. So one
gigabyte is `1024` megabytes, not `1000` megabytes.
+ TODO/FEATURE: verbosity, real-time reporting of bytes read/written, progress
(`processing slice X of Y at NGB per unit`), etc. And switches to turn that
on/off, or send to stderr or stdout, etc. Also a logging option would be nice,
something more than `ginsu slice ... >> /path/to/my.log`.

#### How big you want your file slices?

The final argument to `ginsu` is a string representing how large each file
slice should be, at most. The last file in the series will usually be less than
this size since it'll be the "leftovers", mathematically speaking. Your needs
might entail that you need this sliced into `N` number of files such that each
file is at most 100MB in size. Somebody else may be OK with up to 1GB in size.
Whatever's clever - it's all good.

> FEATURE IDEA: Perhaps some one needs the file sliced into N number of slices
that are *perfectly equal in size*? Can't imagine why off the top of my head,
but that doesn't preclude somebody having the need. So the idea might be to have
the tool take a file of 132.27GB and split it into, say, `100` equally-sized
slices. This would divide the file's size by the number of slices (which the
user supplies) down to the byte level and divvy it out from there. Note that
in cases of division remainders, we have to come up with a way to handle that
so that the resulting byte size of each slice is identical *down to the byte*.
Perhaps pad zeros on the end to make up the difference, then do something like
a `chomp` on the data after merging it back together? I dunno; community
suggestions and comments on this potential feature are welcome.

##### Sizes are strings of `INT{K|M|G}`

Where `INT` is any positive integer between `1-1024`. Why `1024`? Because
that's the math where the next unit of measurement is defined. So for example,
`1024` kilobytes (`K`) is equal to `1` megabyte (`M`). If you defined the
output size as `1024G` you'd basically say "give me an outfile of 1 terabyte",
which is *friggin huge*. If you need to break up a multi-terabyte file, this
is probably not the right tool for you...

**Examples**

| On the Command Line | Means... |
| ------------------- | -------- |
| `500M`              | 500 megabyte files, as many as needed |
| `500MB`             | Exact same thing; failsafe for those of us used to typing `MB` :smiley: |
| `256k`              | Each "slice" should be 256 kilobytes in size |
| `1GB` or `1G`       | Same thing; one gigabyte size per file "slice" |

Some important/ease-of-use notes:

+ The label (`GB` or `g` or `k`, etc.) is **not** case sensitive. Uppercase,
lowercase, mixed - doesn't matter, it's all gravy, baby.
+ You can use `{LABEL}` or `{LABEL}B` interchangeably. So `1g` and `1GB` are
the same as `1Gb` and `1gB` and `1G`. You get the idea.

## Usage Examples

Here are some usage examples to give you a feel for `ginsu`'s overall flavor.

```
$ ginsu chop ~/Projects/archive.tgz /Volumes/Backup/Projects/20160424 250M
```

Takes a file of unknown size from `~/Projects/archive.tgz` and slices it up
into 250 megabyte chunks, putting the resulting chunks *plus some metadata for
joining again later* in `/Volumes/Backup/Projects/20160424/archive.tgz.ginsu`.

Note that in this example, `/Volumes/Backup/Projects/20160424` doesn't exist.
_If the path you specify as to where to store things doesn't exist, `ginsu` will
try to create it for you_. This means _it'll fail if you don't have write permissions to the final storage destination._

```
$ ginsu merge /Volumes/Backup/Projects/20160424/archive.tgz.ginsu ~
```

Take the sliced up `ginsu` output and *merge* it back together, putting the
final resulting file, which will retain its original filename, in your home
directory (which is what `~` means).

**Note that `merge` must be able to read from the first path and write to the
second path. If it can't, it'll exit with an error.**

Also, **if the restore path has a file there already named with whatever the
restored file *should* have been named when the merge was finished, `ginsu` will
warn you and suffix it with `.restored-by-ginsu`.** If you don't like that
filename and/or behavior, well, *make sure your destination directory doesn't
have a conflicting filename!*

> TODO/FEATURE: Add a command to "inspect" the contents of a `.ginsu` directory
so that a user can figure out the basic metadata about the sliced up file. It
should report things like the original filename, date and time it was sliced,
original path it existed in, original machine's hostname, original destination
for the sliced files, each slice's correct md5sum, the completed/merged file's
correct md5sum (to check for corruption), exact byte sizes of each file in the
"archive" and so on.

### How does the resulting "sliced" output look?

`ginsu` creates as many files as necessary to slice up your original big file
into the size of slices you specify, and places them under a new directory
specified as the second argument when invoking `ginsu slice`.

To see what this looks like after all is said and done, look at the contents
of the [`example-outdir.ginsu`](example-outdir.ginsu/) directory in this
repository.
