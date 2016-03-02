Utilities
=========

.. note::

    The documentation in this section is aimed at people wishing to contribute
    to ``histofile``, and can be skipped if you are simply using the tool from
    the command line.

.. data:: ANSI_FG_COLOURS = {…}

    Terminal escapes for colours.

    Foreground colour control codes

.. data:: ANSI_BG_COLOURS = {…}

    Terminal escapes for colours.

    Background colour control codes

.. function:: stylise(text, colour=nil, attrib={bold: false, underline: false}, force=false)

    Generate stylised output for the terminal.

    :param text: Text to format
    :param colour: Colour to use
    :param attrib: Formatting attributes to apply
    :returns: Stylised output

.. function:: success(text, bold=true)

    Standardised success message.

    :param text: Text to stylise
    :param bold: Use bold output

.. function:: fail(text, bold=true)

    Standardised failure message.

    :param text: Text to stylise
    :param bold: Use bold output

.. function:: warn(text, bold=true)

    Standardised warning message.

    :param text: Text to stylise
    :param bold: Use bold output
