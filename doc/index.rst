..
  Don't like reST?  Okay, check out the hosted docs at
  http://histofile.readthedocs.org/

⛬ ``histofile``
================

.. image:: ../extra/histofile.*
   :align: right

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

It is written in moonscript_, and requires v0.3.0 or later.  ``histofile`` is
released under the `GPL v3`_.

:Git repository:  https://github.com/JNRowe/histofile/
:Issue tracker:  https://github.com/JNRowe/histofile/issues/
:Contributors:  https://github.com/JNRowe/histofile/contributors/

Contents
--------

.. toctree::
   :maxdepth: 2

   background
   usage
   getting_started
   histofile manpage <histofile.1>
   faq
   alternatives
   templates
   envvars
   release
   api/index

Indices and tables
------------------

* :ref:`genindex`
* :ref:`modindex`
* :ref:`search`

.. _moonscript: https://github.com/leafo/moonscript/
.. _GPL v3: http://www.gnu.org/licenses/

.. [1] ``git``, and some other VCSes, do support per-file merge tools that can
   make a simple edited file approach work.  Using that may be the best option
   for you!
