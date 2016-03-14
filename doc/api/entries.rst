Entry handling
==============

.. note::

    The documentation in this section is aimed at people wishing to contribute
    to ``histofile``, and can be skipped if you are simply using the tool from
    the command line.

.. function:: wrap_entry(text, width=72, initial_indent="", subsequent_indent=initial_indent)

    Wrap text for output.

    :param text: Text to format
    :param width: Width of formatted text
    :param initial_indent: String to indent first line with
    :param subsequent_indent: String to indent all but the first line with
    :returns: Wrapped text

.. function:: find_entries(path)

    List valid history entries.

    :param path: Path to search
    :returns: Matching entries

.. function:: name_to_time(f)

    Read time from filename

    :param f: Filename to scan
    :returns: ISO-8601 formatted date string
