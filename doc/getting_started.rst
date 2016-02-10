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
    $ histofile update 0.2.0 NEWS.rst
    <fancy new NEWS.rst>

Help on individual subcommands is available via ``histofile <subcommand>
--help`` or in the :doc:`usage` document.
