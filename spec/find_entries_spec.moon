posix = require "posix"

import find_entries from require "histofile"

tdata = (s) -> "spec/find_entries/#{s}"

describe "find_entries", ->
    it "returns nil on empty directories", ->
        temp_dir = posix.mkdtemp "empty.XXXXXX"
        assert.equals find_entries(temp_dir), nil
        posix.rmdir temp_dir

    it "returns all entries", ->
        clear_entries = find_entries tdata "clear"
        assert.equals #clear_entries, 5

    it "returns sorted entries", ->
        clear_entries = find_entries tdata "clear"
        assert.equals clear_entries[1].time, "2016-02-13T19:28:41"
        assert.equals clear_entries[#clear_entries].time,
            "2016-02-13T19:28:42"

    it "ignores non-data files", ->
        dirty_entries = find_entries tdata "dirty"
        assert.equals #dirty_entries, 5
        assert.same [e for e in *dirty_entries when e == "dirty"], {}

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
