Background
==========

One of the most important aspects of creating a new software release is updating
your users with all the fancy new features, deprecated functionality and
breaking changes that may have happened.  Depressingly, this important task is
often rushed in five minutes or skipped entirely.  It can definitely be annoying
having to pour over hundreds of commits to find the important user facing items,
and there should be a tool to automate some of that.

The features *I* need in a tool for this task are:

* Support for multiple branches without having to spend three hours shuffling
  merges
* Easily accessible data, in a format that can be processed simply
* Ability to work off-line, because those times are considerably more common
  than some people seem to think
* Works on all the platforms I regularly use; desktop, mobile phone, ZipIt, and
  more

Now ``histofile`` is born, and I should be able to realise those dreams!

Philosophy
----------

:file:`NEWS` entries should be:

* Written when the commit is made, you shouldn't need to scan diffs from six
  months ago.
* Self-contained, you shouldn't need to handle a heap of merge conflicts because
  you have multiple branches or developers.
* Easy to generate
* Easy to mass process
