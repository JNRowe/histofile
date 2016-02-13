:Author: James Rowe <jnrowe@gmail.com>
:Date: 2016-02-10
:Copyright: GPL v3
:Manual section: 1
:Manual group: user

histofile
=========

Manage version history files
----------------------------

SYNOPSIS
--------

    histofile [option]... <command>

DESCRIPTION
-----------

``histofile`` is a small tool to aid in the management of ``NEWS`` files for
a project.

OPTIONS
-------

--version
    Show the version and exit.

-d <directory>, --directory <directory>
    Location to store history entries, defaults to ``.histofile``.

--help
    Show help message and exit.

COMMANDS
--------

``list``
''''''''

List history entries.

--help
    Show help message and exit.

``new``
'''''''

Add new history entry.

--help
    Show help message and exit.

``update``
''''''''''

Update history file.

-d <date>, --date <date>
    Date of release, defaults to today.

-o <file>, --output <file>
    Output file name.

-k, --keep
    Keep old data files after update (default when writing to stdout).

--help
    Show help message and exit.

BUGS
----

None known.

AUTHOR
------

Written by `James Rowe <mailto:jnrowe@gmail.com>`__

RESOURCES
---------

..
    Home page, containing full documentation: http://histofile.rtfd.org/

Issue tracker: https://github.com/JNRowe/histofile/issues/

COPYING
-------

Copyright © 2016  James Rowe.

This program is free software: you can redistribute it and/or modify it
under the terms of the GNU General Public License as published by the
Free Software Foundation, either version 3 of the License, or (at your
option) any later version.
