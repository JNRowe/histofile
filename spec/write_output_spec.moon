posix = require "posix"

import write_output from require "histofile"


describe "write_output", ->
    it "writes to file", ->
        tmp = posix.basename os.tmpname!
        write_output tmp, "test"
        with io.open tmp
            assert.same \read("*a"), "test"
        os.remove tmp

    it "writes to stdout with -", ->
        stdout = io.stdout
        with tmp = io.tmpfile!
            io.stdout = tmp
            write_output "-", "test"
            \seek "set"
            \flush!
            assert.same \read("*a"), "test"
        io.stdout = stdout

    it "writes array of lines", ->
        tmp = posix.basename os.tmpname!
        write_output tmp, {"test", "lines"}
        with io.open tmp
            assert.same \read("*a"), "test\nlines"
        os.remove tmp
