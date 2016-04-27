# Do not edit anything in this folder.

This directory, and everything within it, were created with [ginsu][], a tool for slicing very large files into smaller, more manageable ones. As such, the files located inside this directory are **absolutely NOT to be used outside of the `ginsu` tool!** Don't try to edit them by hand; they're likely just binary junk (and may even be encrypted) anyway.

[TOC]

## If you want to restore the original file...

...all you need to do is use the `ginsu restore` command, like so:

```sh
ginsu restore <path to this directory> <where you want the restored file>
```

That's literally all there is to it. For example, if I had a `ginsu` slice directory named `my-big-backup.ginsu` located at `/Volumes/MyBackupDrive/my-big-backup.ginsu` and wanted to assemble ("restore") the original file to `~/restored-backup.tar.gz`, I might use this command:

`ginsu restore /Volumes/MyBackupDrive/my-big-backup.ginsu $HOME/restored-backup.tar.gz`

(Note in the example above, the `\` is there to explain that what goes on the following line should actually be on the first line. It's a formatting thing just for the sake of this document.)

Once the file is restored, you need to decompress it or un-tar it using the same toolset you used to create the archive in the first place. This tool _does not_ automatically decompress the file for you, nor does it handle any kind of encryption or decryption, as it makes no assumptions about such things, thus allowing for maximum flexibility.

## More Information / Documentation

You can find more information about `ginsu` and how to use it at its official open source repository, located at:

<https://github.com/insurrectiondigital/ginsu>

### Developer Information, Legal Info and Open Source Status

This tool is created by [Insurrection Digital, LLC]() and is licensed under the [MIT License][license].

(C) Copyright 2016 Insurrection Digital, LLC.

#### Open Source / "free as-in freedom"

The source code for this tool is openly available, in whole, to the public at large over the internet. This is important not only because it reduces the cost to acquire this tool to zero, but *because you have a __right__ to know what software you use is doing behind the scenes.* And because you are able to review and audit this source code any time you want, you can exercise that right to its fullest extent.


[ginsu]: http://github.com/insurrectiondigital/ginsu 'ginsu'
[license]: http://github.com/insurrectiondigital/ginsu 'license'
[insurection]: http://insurrection.cc 'Insurrection Digital, LLC'
