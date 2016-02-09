histofile - Manage version history files
========================================

``histofile`` is a small tool to aid in the management of ``NEWS`` files for
a project.

The intention is that each time you commit or merge a change that warrants an
entry in your ``NEWS`` file you also add a new ``histofile`` data file.  When it
is time to cut a new release you tell ``histofile``, and it updates your
``NEWS`` file from your pre-existing entries.

This *should* save an enormous amount of time, as it reduces the need to scan
through the commit log then manually create a ``NEWS`` file.

The data files are stored as plaintext in your chosen directory with one file
per entry, which means unlike a developer updated ``NEWS`` file in your
repository ``histofile`` should work easily across merges [1]_.

``histofile`` is released under the `GPL v3`_ license.

Requirements
------------

``histofile``'s dependencies beyond lua_ are:

* argparse_
* luaposix_

It should work with any version of ``lua`` v5.1 or newer, and also with
``luajit``.  If ``histofile`` doesn't work with the version of lua you have
installed, file an issue_ and I'll endeavour to fix it.

The package has been tested on many UNIX-like systems, including Linux and OS
X, but it should work fine on other systems too.

The excellent moonscript_ is required at build time, but it doesn't need to be
installed to use ``histofile``.

Contributors
------------

I'd like to thank the following people who have contributed to ``histofile``.

Patches
'''''''

* <your name here>

Bug reports
'''''''''''

* <your name here>

Ideas
'''''

* <your name here>

If I've forgotten to include your name I wholeheartedly apologise.  Just drop me
a mail_ and I'll update the list!

Bugs
----

If you find any problems, bugs or just have a question about this package either
file an issue_ or drop me a mail_.

If you've found a bug please attempt to include a minimal testcase so I can
reproduce the problem, or even better a patch!

.. _GPL v3: http://www.gnu.org/licenses/
.. _lua: http://www.lua.org/
.. _argparse: https://github.com/mpeterv/argparse
.. _luaposix: http://wiki.alpinelinux.org/wiki/Luaposix
.. _moonscript: https://github.com/leafo/moonscript/
.. _issue: https://github.com/JNRowe/histofile/issues
.. _mail: jnrowe@gmail.com

.. [1] ``git``, and some other VCSes, do support per-file merge tools that can
   make a simple edited file approach work.  Using that may be the best option
   for you!