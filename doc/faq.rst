Frequently Asked Questions
--------------------------

..
    Ask them, and perhaps they'll become frequent enough to be added here ;)

.. contents::

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
