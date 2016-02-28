Frequently Asked Questions
--------------------------

..
    Ask them, and perhaps they'll become frequent enough to be added here ;)

.. contents::
   :local:

Can I use an editor to write entries?
'''''''''''''''''''''''''''''''''''''

I've thought about it a lot, and I'm not convinced it is a good idea to make
:program:`histofile new` call an editor with empty arguments. Having to think
about fitting the entry in to a reasonable size to write at the shell prompt
just *feels* right; NEWS entries just shouldn't be essays.

That said, you can edit the files after creation or use your shell's command
substitution to work around my possibly misplaced ideals.

I'm not totally opposed to it however, and would likely accept a pull request
that implements it should someone feel strong enough about it.

Why not Markdown?
'''''''''''''''''

There is no reason Markdown-style output can't be supported, it is just the
default template that uses reST_ formatting.

The simple reason reST_ output was chosen at the start is that no project I
work on would welcome the addition of a Markdown file.  The major sticking
point being that nobody appears to know what constitutes a valid Markdown
document.  Even the simple matter of whether to wrap lines or not is up for
discussion with every parser.

That said, nothing stops you from implementing a Markdown-ish generating
template and opening a pull request.  In fact, adding a `GitHub Flavoured
Markdown`_ template is kind of on my TODO list, but admittedly very low as I
have no personal use for it myself.

.. _reST: http://docutils.sourceforge.net/rst.html
.. _GitHub Flavoured Markdown: http://github.github.com/github-flavored-markdown/
