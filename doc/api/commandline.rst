Command line
============

.. note::

  The documentation in this section is aimed at people wishing to contribute to
  ``histofile``, and can be skipped if you are simply using the tool from the
  command line.

Commands
''''''''

.. function:: commands.list(args)

    List history entries.

    :param table args: Parsed arguments
    :rtype: int
    :returns: 0 on success, 2 when no entries are found

.. function:: commands.new(args)

    Add new history entry.

    :param table args: Parsed arguments
    :rtype: int
    :returns: 0 on success, 5 when writing fails

.. function:: commands.update(args)

    Update history file.

    :param table args: Parsed arguments
    :rtype: int
    :returns: 0 on success, 2 when no entries are found

Entry points
'''''''''''''

.. function:: main()

    Main entry point.

CLI support
'''''''''''

.. function:: parse_args()

    Parse command line arguments.

    :rtype: table
    :returns: Processed command line arguments
