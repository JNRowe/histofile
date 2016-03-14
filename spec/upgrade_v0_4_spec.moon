posix = require "posix"

import find_entries from require "upgrade_v0_4"

tdata = (s) -> "spec/upgrade_v0_4/find_entries/#{s}"

describe "find_entries", ->
    it "reads pre-0.2.0 data files", ->
        old_entries = find_entries tdata "pre_0_2_0"
        assert.equals #old_entries, 5
        assert.equals old_entries[#old_entries].time,
            "2016-02-13T19:28:42"

    it "reads pre-0.4.0 data files", ->
        old_entries = find_entries tdata "pre_0_4_0"
        assert.equals #old_entries, 5
        assert.equals old_entries[#old_entries].time,
            "2016-02-13T19:28:42"
