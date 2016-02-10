#
# coding=utf-8
"""conf - Sphinx configuration information."""
# Copyright © 2016  James Rowe <jnrowe@gmail.com>
#
# This file is part of histofile.
#
# histofile is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, either version 3 of the License, or (at your option) any later
# version.
#
# histofile is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with
# histofile.  If not, see <http://www.gnu.org/licenses/>.

from subprocess import (CalledProcessError, check_output)

extensions = []

# Only activate spelling if it is installed.  It is not required in the
# general case and we don't have the granularity to describe this in a clean
# way
try:
    from sphinxcontrib import spelling  # NOQA
except ImportError:
    pass
else:
    extensions.append('sphinxcontrib.spelling')

master_doc = "index"
source_suffix = ".rst"

project = "histofile"
copyright = u"Copyright © 2016  James Rowe <jnrowe@gmail.com>"

# Use versionah
version = "0.2"
release = "0.2.0"

pygments_style = "sphinx"
try:
    html_last_updated_fmt = check_output(["git", "log",
                                          "--pretty=format:'%ad [%h]'",
                                          "--date=short", "-n1"])
except CalledProcessError:
    pass

man_pages = [
    ("histofile.1", "histofile", u"histofile Documentation",
     ["James Rowe", ], 1)
]

spelling_lang = 'en_GB'
spelling_word_list_filename = 'wordlist.txt'
