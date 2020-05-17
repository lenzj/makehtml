# makeht

This is a makefile based static website generator.  Files are authored in the
"src" subdirectory using a standard text editor with markdown or html a
desired.  A template processor is also used which enables standard page header,
footers, and other common information across various web pages.

The makefile is set up to recognize and process files based on their filename
extension.  The following file types are currently handled:

* .got - These are the primary content files which are translated into html.
  These are golang template files for processing by the
  [pgot](https://git.lenzplace.org/lenzj/pgot) utility.  The file types that follow are typically
  referred to within these .got files.

* .igot - These are intended to be "included" in the frontmatter section of the
  .got files above and typically contain global variables or content to
  standardize across web pages.

* .cpy - Files intended to be copied over directly into the build directory
  without any type of translation.  The cpy file extension is removed in the
  process.

* .raw - Raw files are binary files that are not stored efficiently within git.
  These are the only content files that are ignored by git and are handled
  separately using the [cogit](#cogit) methodology described below.  These are
  copied directly into the build directory with the raw file extension removed.

Note that folders are only created in the build directory if they contain
content files.  Case in point, the "inc" folder within the "src" directory is
not mirrored into the "bld" folder because it only contains igot files.  Since
igot files are by definition only included in other got files they do not
create content on their own and as such the inc folder does not need to be
created in the corresponding "bld" directory.

Once files have been authored, these are mirrored and transformed into final
html in the "bld" subdirectory.  The user can make a local version using the
following command in order to browse and confirm content/appearance using a
standard web browser.  The generated files are stored in the "bld/loc" sub
folder.

    $ make loc

Once satisfied with the results the user can then make a public version using
the following command.  The files are similarly stored in the "bld/pub" sub
folder.

    $ make pub

The files in the "bld/pub" folder can be copied to the destination server
address using scp, rsync, etc.

## Installing

To install, clone the git repository and ensure you have the
[dependencies](#dependencies) in the section below installed.

In addition you will need to download the latest "cogit" file set from the
[release](https://git.lenzplace.org/lenzj/makeht/releases) folder.  This is a tar archive containing
any images or video etc. used by this website.  See the [cogit](#cogit) section
below for more background info.  There is currently only one file in the makeht
cogit archive, and it is mainly included to demonstrate the cogit method.  From
within the main git repository you can then extract the tar archive as follows
(assuming the downloaded cogit tar archive is in your ~/Download folder) and it
will populate the cogit files into the "src" directory.

    $ tar -xf ~/Download/makeht-cogit-20XX-XX-XX.tar

You should then execute the configure script which selects the appropriate
Makefile version depending on which operating system you are using (linux or
bsd).

    $ ./configure

You should edit the following line near the top of the Makefile to match the
public server address that you plan to use.

    MYSERVER=my.blog.site

You can then either edit / create files directly in the "src" sub folder in the
repository or alternately copy all the files in the git repository to a
separate folder or repository of your choice.  The src sub folder currently
contains a skeleton blog site with placeholder information that you can edit as
a starting point or alternately wipe it clean and start with your own format.
A screen shot of the skeleton blog is shown below.

![](screen_shot.png "screen shot")

Lastly, you can then execute "make loc" to generate a local set of files that
you can browse with your default web browser.

    $ make loc
    $ xdg-open bld/loc/index.html

## Dependencies
+ __make__ (any posix compliant make utility) Used to identify items that have
  changed and convert those into final html files for a website using the tools
  above.
+ __pgot__ (https://git.lenzplace.org/lenzj/pgot) A template processing tool
  written in golang.
+ __chuf__ (https://git.lenzplace.org/lenzj/chuf) An inline chunk filtering
  tool written in golang (used to select sections for markdown processing).
+ __markdown__ I use discount as the markdown processor.
  <http://www.pell.portland.or.us/~orc/Code/discount/>
+ __unix utilities__ The following standard unix utilities are needed and
  should be available in most linux/bsd default installations: find, tar, grep,
  sort, sha256sum

## Folder structure

This can be created as desired.  One recommended folder layout is as follows:

```text
+- Makefile
+- src : All templates and source text files are in this folder.
|  +- css : html cascading style sheets
|  +- inc : These are .igot templates that are included or referenced by
|           individual content pages in src.  Global variables can be defined
|           here etc.
|  +- topic1 : Website topics are stored in different sub folders.
|  +- topic2 : etc. ...
+- bld : All output is written to this folder.
|  +- loc : This folder is generated with "make loc", and can be viewed with
|           a standard web browser.
|  +- pub : This folder contains files which are intended for the public web
|           server.  These files can be directly copied to the server.
+- template : You can safely ignore this folder unless you want to update the
              README or LICENSE files.  Further detail is in the folder.
```

## Cogit

Websites typically have a variety of raw binary data files including images,
video, icons, etc.  Git works exceptionally well for text files, but is not a
good tool for storing these types of binary files.  The git LFS system has been
developed to handle this situation, however a specialized LFS server is needed.
An alternate strategy is used here which I am calling "cogit" (raw binary files
cohabitating with git).  The .gitignore file specifies the raw files and/or
folders to be ignored by git.  The Makefile generates a manifest text file
containing lines with a sha256sum first followed by the sub path/name for each
raw binary file.  The manifest is tracked in git so that the even though the
raw files are not stored in git the user can determine exactly which set of raw
files is associated with each commit.  A tarball containing the raw files can
be created and stored separately from the git respository.

## Contributing

If you have a bugfix, update, issue or feature enhancement the best way to reach
me is by following the instructions in the link below.  Thank you!

<https://blog.lenzplace.org/contact>

## Versioning

I follow the [SemVer](http://semver.org/) strategy for versioning. The latest
version is listed in the [releases](/lenzj/makeht/releases) section. 

## License

This project is licensed under a BSD two clause license - see the
[LICENSE](LICENSE) file for details.
