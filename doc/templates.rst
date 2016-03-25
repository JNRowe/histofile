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

It is matched with lua_'s string.match_ function, and should be as tight as
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

The following formatting functions are provided for convenience:

+---------------------+-------------------------------------------------------+
| Function            | Description                                           |
+=====================+=======================================================+
| :func:`stylise`     | Basic terminal formatting support                     |
+---------------------+-------------------------------------------------------+
| :func:`wrap_entry`  | A simple line wrapper for text inputs                 |
+---------------------+-------------------------------------------------------+

Along with the following variables for formatting output:

+-----------+----------------------+------------------------------------------+
| Variable  | Type                 | Description                              |
+===========+======================+==========================================+
| bg        | string indexed table | Colours to set terminal background.      |
+-----------+----------------------+------------------------------------------+
| bold      | string               | Set terminal to bold                     |
+-----------+----------------------+------------------------------------------+
| fg        | string indexed table | Colours to set terminal foreground.      |
+-----------+----------------------+------------------------------------------+
| form_feed | string               | Force a form feed                        |
+-----------+----------------------+------------------------------------------+
| reset     | string               | Reset terminal formatting                |
+-----------+----------------------+------------------------------------------+
| underline | string               | et terminal to underline                 |
+-----------+----------------------+------------------------------------------+

.. _etlua: https://github.com/leafo/etlua
.. _lua: http://www.lua.org/
.. _reST: http://docutils.sourceforge.net/
.. _table of contents directive: http://docutils.sourceforge.net/docs/ref/rst/directives.html#table-of-contents
.. _string.match: https://www.lua.org/manual/5.3/manual.html#pdf-string.match
