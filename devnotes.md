# Developer's Notes

Things I'm thinking of while doing other things; using this somewhat as a
scratchpad for obvious reasons and in hopes of sparking community discussion
around where my head's at with these ideas.

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
