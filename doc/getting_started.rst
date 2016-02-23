Getting started
===============

Basic usage
-----------

The command interface is hopefully quite intuitive.  The following is a sample
session:

.. code-block:: console

    $ histofile new "Add support for cake baking"
    $ histofile new "Removed support for window cleaning"
    $ histofile list
    2016-02-10T12:03:00     Add support for cake baking
    2016-02-10T12:03:05     Removed support for window cleaning
    $ histofile update --output - 0.2.0 NEWS.rst
    <fancy new NEWS.rst>
    $ histofile update 0.2.0 NEWS.rst
    <NEWS.rst is updated in place>

Help on individual subcommands is available via ``histofile <subcommand>
--help`` or in the :doc:`usage` document.

Configuration
-------------

``histofile`` ships with what the maintainer hopes are reasonable defaults, but
can be configured in various ways.

``histofile`` will read argument defaults from :file:`.histofile.json` or the
file pointed to by :envvar:`HISTOFILE_CONFIG`.  The file should be a valid JSON
document, and can contain the following items:

+---------------+------+------------------------------------------------------+
| Variable      | Type | Description                                          |
+===============+======+======================================================+
| directory     | str  | The directory to read and write NEWS entries to      |
+---------------+------+------------------------------------------------------+
| filename      | str  | The filename to use as the NEWS file                 |
+---------------+------+------------------------------------------------------+
| keep          | bool | Whether to keep the entries after writing updates    |
+---------------+------+------------------------------------------------------+
| template_name | str  | The template set used to render the NEWS file        |
+---------------+------+------------------------------------------------------+

For example, a configuration file could contain the following:

.. code-block:: json

    {
        "directory": "/out/of/tree/storage",
        "filename": "awful_name.md"
    }
