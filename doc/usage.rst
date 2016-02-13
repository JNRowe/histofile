Usage
=====

The :program:`histofile` script is the main workhorse of ``histofile``.

See :doc:`getting_started` for basic usage examples.

Options
-------

.. program:: histofile

.. option:: --version

   Show the version and exit.

.. option:: -d <directory>, --directory=<directory>

   Database location, defaults to ``.histofile``.

.. option:: --help

   Show help message and exit.

Commands
--------

``list`` - List history entries
'''''''''''''''''''''''''''''''

.. program:: histofile list

::

    histofile list [--help]

.. option:: --help

   Show help message and exit.

``new`` - Add new history entry
'''''''''''''''''''''''''''''''

.. program:: histofile new

::

    histofile new <entry>

.. option:: --help

   Show help message and exit.

``update`` - Update history file
''''''''''''''''''''''''''''''''

.. program:: histofile update

::

    histofile update [--help] <version> <file>

.. option:: -d <date>, --date <date>

   Date of release, defaults to today.

.. option:: -o <file>, --output <file>

   Output file name.

.. option:: -k, --keep

   Keep old data files after update (default when writing to stdout).

.. option:: --help

   Show help message and exit.
