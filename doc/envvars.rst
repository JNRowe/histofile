Configuration via environment variables
=======================================

:program:`histofile` defaults for some options can be configured via
environment variables.  The design purpose for supporting these environment
variables is to make it easy for users to configure per-project defaults using
shell hooks.

.. envvar:: HISTOFILE_CONFIG

   This should point to a valid JSON_ file containing option defaults, see
   :ref:`JSON-configuration` for the accepted keys and their possible values.

.. _JSON: http://www.json.org/
