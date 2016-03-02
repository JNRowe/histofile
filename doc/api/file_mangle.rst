File handling
=============

.. note::

    The documentation in this section is aimed at people wishing to contribute
    to ``histofile``, and can be skipped if you are simply using the tool from
    the command line.

.. function:: find_old_entries(data, marker_string)

    Find old NEWS entries.

    :param data: Data to operate on
    :param marker_string: Match location to find old entries
    :returns: Old entries

.. function:: write_output(file, content)

    Write output to file or stdout.

    :param file: Output file name
    :param content: Strings, or table of strings, to write
    :returns: 0 on success, (errno, reason) on failure
