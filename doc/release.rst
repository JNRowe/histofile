Release HOWTO
=============

.. highlight:: sh

..
  Much of this stuff is automated locally, but I'm describing the process for
  other people who will not have access to the same release tools I use.  The
  first thing I recommend that you do is find/write a tool that allows you to
  automate all of this, or you're going to miss important steps at some point.

..
    Test
    ----

    In the general case tests can be run via ``busted``::

        $ busted --verbose

    When preparing a release it is important to check that ``histofile`` works
    with all supported lua versions, and that the documentation is correct.

Prepare release
---------------

..
    With the tests passing, perform the following steps

* Update the version data in :file:`version.moon`
* Update :file:`NEWS.rst`, with ``histofile`` ;)
* Commit the release notes and version changes
* Create a signed tag for the release
* Push the changes, including the new tag, to the GitHub repository
* Create new release on GitHub

Announce release
----------------

Check the generated tarballs for errors; missing files, stale files, &c

You should also perform test installations, to check the experience
``histofile`` users will have.
