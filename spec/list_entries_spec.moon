posix = require "posix"

import list_entries from require "histofile"

tdata = (s) -> "spec/list_entries/#{s}"

describe "list_entries", ->
    it "returns nil on empty directories", ->
        temp_dir = posix.mkdtemp "empty.XXXXXX"
        assert.equals list_entries(temp_dir), nil
        posix.rmdir temp_dir
        print posix.getcwd!

    it "returns all entries", ->
        clear_entries = list_entries tdata "clear"
        assert.equals #clear_entries, 5

    it "returns sorted entries", ->
        clear_entries = list_entries tdata "clear"
        assert.equals clear_entries[1], tdata "clear/1455391721.578775.txt"
        assert.equals clear_entries[#clear_entries],
            tdata "clear/1455391722.127459.txt"

    it "ignores non-data files", ->
        dirty_entries = list_entries tdata "dirty"
        assert.equals #dirty_entries, 5
        assert.same [e for e in *dirty_entries when e == "dirty"], {}

    it "reads pre-0.2.0 data files", ->
        old_entries = list_entries tdata "pre_0_2_0"
        assert.equals #old_entries, 5
        assert.equals old_entries[#old_entries],
            tdata "pre_0_2_0/1455391722.txt"
