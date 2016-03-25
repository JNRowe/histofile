Interface support
=================

.. note::

    The documentation in this section is aimed at people wishing to contribute
    to ``histofile``, and can be skipped if you are simply using the tool from
    the command line.

.. function:: main()

    Main entry point.

    Calls os.exit_ on completion.

.. _os.exit: https://www.lua.org/manual/5.3/manual.html#pdf-os.exit

``commands`` table
''''''''''''''''''

.. function:: list(args)

    List history entries.

    :param args: Parsed arguments
    :returns: Exit code suitable for shell

.. function:: new(args)

    Add new history entry.

    :param args: Parsed arguments
    :returns: Exit code suitable for shell

.. function:: update(args)

    Update history file.

    :param args: Parsed arguments
    :returns: Exit code suitable for shell
