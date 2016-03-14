Utilities
=========

.. note::

  The documentation in this section is aimed at people wishing to contribute to
  ``histofile``, and can be skipped if you are simply using the tool from the
  command line.

Data loading
''''''''''''

.. function:: find_entries(path)

    :param str path: Path to search
    :rtype: table
    :returns: Matching entries

.. function:: find_marker(file)

    Find location to insert new entries

    :param str file: File to operate on
    :rtype: int
    :returns: Line to insert new entries

.. function:: read_config()

    Read repository configuration.

    :rtype: table
    :returns: Configuration data

File creation
'''''''''''''

.. function:: build_file(file, marker, entries, version, date)

    Generate new NEWS file

    :param str file: File to operate on
    :param int marker: Line to insert new text at
    :param table entries: New entries to insert
    :rtype: table
    :returns: Lines comprising complete output

.. function:: write_output(ofile, output)

    Write output to file or stdout

    :param str ofile: Output file name
    :type output: str or table
    :param str output: Output to write

Text formatting
'''''''''''''''

.. function:: colourise(text, colour, attrs, force)

    Generate coloured output for the terminal.

    :param str text: Text to colourise
    :param str colour: Colour to use
    :param table attrs: Whether to produce bold or underlined output
    :param bool force: Colourise regardless of whether ``stdout`` is connected
        to a terminal
    :rtype: str
    :returns: Colourised output

.. function:: success(text, bold)

    Standardised success message.

    :param str text: Text to colourise
    :param bool bold: Use bold output
    :rtype: str
    :returns: Prettified success message

.. function:: fail(text, bold)

    Standardised failure message.

    :param str text: Text to colourise
    :param bool bold: Use bold output
    :rtype: str
    :returns: Prettified failure message

.. function:: warn(text, bold)

    Standardised warning message.

    :param str text: Text to colourise
    :param bool bold: Use bold output
    :rtype: str
    :returns: Prettified warning message

.. function:: wrap_entry(text, width, initial_indent, subsequent_indent)

    Wrap text for output

    :param str text: Text to format
    :param int: Width of formatted text
    :param str initial_indent: String to indent first line with
    :param str subsequent_indent: String to indent all but the first line with
    :rtype: str
    :returns: Line wrapped text
