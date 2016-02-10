Utilities
=========

.. note::

  The documentation in this section is aimed at people wishing to contribute to
  ``histofile``, and can be skipped if you are simply using the tool from the
  command line.

Convenience functions
'''''''''''''''''''''

.. function:: list_entries(path)

    :param str path: Path to search
    :rtype: table
    :returns: Matching entries

Text formatting
'''''''''''''''

.. function:: colourise(text, colour, bold, underline)

    Generate coloured output for the terminal.

    :param str text: Text to colourise
    :param str colour: Colour to use
    :param bool bold: Use bold output
    :param bool underline: Use underline output
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
