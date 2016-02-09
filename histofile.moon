#! /usr/bin/env moon

NAME = "histofile"
DESCRIPTION = "Manage version history files"

argparse = require "argparse"
posix = require "posix"

VERSION = require "version"

HISTORY_TEMPLATE = "User-visible changes
====================

.. contents::
"
MARKER_STRING = "^%.%. contents::"


-- Coloured output support {{{

--- Terminal escapes for colours
ANSI_COLOURS = {s, n+29 for n, s in ipairs {"black", "red", "green", "yellow",
                                            "blue", "magenta", "cyan", "white"}}


--- Generate coloured output for the terminal.
-- @param text Text to colourise
-- @param colour Colour to use
-- @param bold Use bold output
-- @param underline Use underline output
-- @return Colourised output
colourise = (text, colour=nil, bold=false, underline=false using nil) ->
    s = ""
    if colour
        s ..= "\027[#{ANSI_COLOURS[colour]}m"
    if bold
        s ..= "\027[1m"
    if underline
        s ..= "\027[4m"
    "#{s}#{text}\027[0m"


--- Standardised success message.
-- @param text Text to colourise
-- @param bold Use bold output
-- @return Prettified success message
success = (text, bold=true) ->
    print colourise "✔ #{text}", "green", bold


--- Standardised failure message.
-- @param text Text to colourise
-- @param bold Use bold output
-- @return Prettified failure message
fail = (text, bold=true) ->
    io.stderr\write colourise("✘ #{text}", "red", bold) .. "\n"


--- Standardised warning message.
-- @param text Text to colourise
-- @param bold Use bold output
-- @return Prettified warning message
warn = (text, bold=true) ->
    io.stderr\write colourise("⚠ #{text}", "yellow", bold) .. "\n"
-- }}}


--- List valid history entries.
-- @param path Path to search
-- @return Matching entries
list_entries = (path using nil) ->
    files = posix.glob "#{path}/[0-9][0-9]*.txt"
    if files
        table.sort files
    return files


--- Parse command line arguments.
-- @return Processed command line arguments
parse_args = (using nil) ->
    parser = with argparse(NAME)
            description: DESCRIPTION
            epilog: "Please report bugs at https://github.com/JNRowe/#{NAME}/issues"

        \flag "-v", "--version"
            description: "Show the version and exit."
            action: ->
                print "#{NAME}, version #{VERSION.dotted}"
                os.exit 0
        \option "-d", "--directory"
            description: "Location to store history entries."
            default: ".histofile"
        \command "list"
            description: "List history entries."
        \command "new"
            description: "Add new history entry."
        \command "update"
            description: "Update history file."

    -- If nested with statements worked, this could look and feel far cleaner
    for _, command in pairs parser._commands
        switch command._name
            when "list"
                noop
            when "new"
                with command
                    \argument "entry"
                        description: "History entry to add."
            when "update"
                with command
                    \argument "version"
                        description: "Version number of release."
                        convert: (s) -> s\match "^%d+%.%d+%.%d+$"
                    \argument "file"
                        description: "Location of history file."
                        default: "NEWS"
                    \option "-d", "--date"
                        description: "Date of release."
                        default: os.date "%Y-%m-%d"
                        convert: (s) -> s\match "^%d%d%d%d%-%d%d%-%d%d$"
            else
                error "Unknown command"  -- To catch API changes mostly
    args = parser\parse!
    args.command = if args.list
        "list"
    elseif args.new
        "new"
    else
        "update"
    return args

-- Main commands {{{

commands =
    --- List history entries.
    -- @param args Parsed arguments
    list: (args using nil) ->
        if entries = list_entries args.directory
            for entry in *entries
                time = tonumber entry\match "#{args.directory}/(.*)%.txt"
                with io.open entry
                    print colourise(os.date("%Y-%m-%dT%H:%M:%S", time), "magenta"),
                        \read("*a")
                    \close!
        else
            fail "No entries"
            return posix.ENOENT
        return 0


    --- Add new history entry.
    -- @param args Parsed arguments
    new: (args using nil) ->
        unless posix.stat("#{args.directory}", "type") == "directory"
            posix.mkdir args.directory
        name = "#{args.directory}/#{os.date '%s'}.txt"
        if file = io.open name, "w"
            file\write args.entry
            file\close
        else
            fail "ick!  Write failure"
            return posix.EIO
        return 0


    --- Update history file.
    -- @param args Parsed arguments
    update: (args using nil) ->
        entry_to_bullet = (entry using nil) ->
            text = "* "
            file = io.open entry
            text ..= file\read("*a")\gsub "\n$", ""
            file\close!
            return text

        if entries = list_entries args.directory
            if file = io.open args.file
                marker = 0
                for line in file\lines!
                    if line\find MARKER_STRING
                        break
                    marker += 1
                file\seek "set"
                current = 0
                for line in file\lines!
                    if current != marker
                        print line
                    else
                        print line
                        print ""
                        header = "#{args.version} - #{args.date}"
                        print header
                        print "-"\rep(#header)
                        print ""
                        for entry in *entries
                            print entry_to_bullet entry
                    current += 1
                file\close!
            else
                print HISTORY_TEMPLATE
        else
            fail "No entries"
            return posix.ENOENT
        return 0
-- }}}


--- Main entry point.
main = (using nil) ->
    args = parse_args!

    os.exit commands[args.command] args

main!
