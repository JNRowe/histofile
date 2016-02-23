Templates
=========

Templates are implemented using the excellent etlua_ package.

Files
-----

Each template set is a pair of files; :file:`marker` and :file:`main.etlua`.


``marker``
''''''''''

The :file:`marker` file contains a "magic" string, that is used to find the
location in the :file:`NEWS` file to insert new entries.

It is matched with lua_'s :func:`str.match` function, and should be as tight as
possible to prevent false matches.  The default template's :file:`marker` is
``%.%. contents::`` which matches a reST_ `table of contents directive`_.

``main.etlua``
''''''''''''''

The :file:`main.etlua` file is the template that is used to generate the header
and individual entries for the :file:`NEWS` file.

It is provided with the following data:

+-------------+---------------------------------------------------------------+
| Variable    | Description                                                   |
+=============+===============================================================+
| date        | The data provided by the user with the :option:`--date`       |
|             | option.                                                       |
+-------------+---------------------------------------------------------------+
| entries     | The new entries to add to the output.                         |
+-------------+---------------------------------------------------------------+
| old_entries | The previously existing data in the :file:`NEWS` file.        |
+-------------+---------------------------------------------------------------+
| version     | The version provided by the user with the ``version``         |
|             | argument.                                                     |
+-------------+---------------------------------------------------------------+

And the following functions:

+---------------------+-------------------------------------------------------+
| Function            | Description                                           |
+=====================+=======================================================+
| :func:`wrap_entry`  | A simple line wrapper for text inputs                 |
+---------------------+-------------------------------------------------------+

.. _etlua: https://github.com/leafo/etlua
.. _lua: http://www.lua.org/
.. _reST: http://docutils.sourceforge.net/
.. _table of contents directive: http://docutils.sourceforge.net/docs/ref/rst/directives.html#table-of-contents
