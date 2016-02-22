#! /usr/bin/env moon
--
-- Copyright © 2016  James Rowe <jnrowe@gmail.com>
--                   Nathan McGregor <nathan.mcgregor@astrium.eads.net>
--
-- This file is part of histofile.
--
-- histofile is free software: you can redistribute it and/or modify it under
-- the terms of the GNU General Public License as published by the Free Software
-- Foundation, either version 3 of the License, or (at your option) any later
-- version.
--
-- histofile is distributed in the hope that it will be useful, but WITHOUT ANY
-- WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
-- A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License along with
-- histofile.  If not, see <http://www.gnu.org/licenses/>.

NAME = "histofile"
DESCRIPTION = "Manage version history files"

argparse = require "argparse"
dkjson = require "dkjson"
posix = require "posix"

-- Use the large LPeg speedups for dkjson when LPeg is available.  Note, that
-- it is unlikely to make enough difference to warrant a hard dependency on
-- LPeg unless you have *thousands* of NEWS entries.
pcall dkjson.use_lpeg

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
    unless posix.ttyname 1
        return text
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


--- Wrap text for output
-- @param text Text to format
-- @param width Width of formatted text
-- @initial_indent String to indent first line with
-- @subsequent_indent String to indent all but the first line with
wrap_entry = (text, width=72, initial_indent="", subsequent_indent=initial_indent using nil) ->
    pos = 1 - #initial_indent
    initial_indent .. text\gsub "(%s+)()(%S+)()", (_, start, word, _end using pos) ->
        if _end - pos > width
            pos = start - #subsequent_indent
            "\n#{subsequent_indent}#{word}"


--- List valid history entries.
-- @param path Path to search
-- @return Matching entries
find_entries = (path using nil) ->
    name_to_time = (f) ->
        time = tonumber f\match "/(%d+%.?%d+)%."
        os.date "%Y-%m-%dT%H:%M:%S", time
    files = {}
    if json_files = posix.glob "#{path}/[0-9][0-9]*[.0-9][0-9]*.json"
        local entry
        for f in *json_files
            with io.open f
                entry = dkjson.decode \read("*a")
                \close!
            entry.time = name_to_time f
            entry._filename = f
            table.insert files, entry
    -- Old histofile <0.4 files
    if txt_files = posix.glob "#{path}/[0-9][0-9]*[.0-9][0-9]*.txt"
        warn "Support for old .txt histofile(<v0.4) files will be removed in v0.5"
        for f in *txt_files
            with io.open f
                message = \read("*a")
                \close!
                table.insert files, {
                    :message
                    time: name_to_time f
                    _filename: f
                }
    if #files == 0
        return nil, "No entries found"
    table.sort files, (e1, e2) -> e1.time < e2.time
    return files

-- File mangling functionality {{{

--- Find location to insert new entries
-- @param file File to operate on
-- @return Line to insert new entries
find_marker = (file using nil) ->
    curpos = file\seek!
    file\seek "set"
    marker = 0
    for line in file\lines!
        if line\find MARKER_STRING
            break
        marker += 1
    file\seek "set", curpos
    return marker


--- Generate new NEWS file
-- @param file File to operate on
-- @param marker Line to insert new text at
-- @param entries New entries to insert
-- @return Lines comprising complete output
build_file = (file, marker, entries, version, date using nil) ->
    output = {}
    ins = (text) -> table.insert output, text
    current = 0
    for line in file\lines!
        if current != marker
            ins line
        else
            ins line
            ins ""
            header = "#{version} - #{date}"
            ins header
            ins "-"\rep(#header)
            ins ""
            for _, entry in pairs entries
                ins wrap_entry entry.message, 72, "* ", "  "
        current += 1
    ins ""
    return output


--- Write output to file or stdout
-- @param ofile Output file name
-- @param output Strings, or table of strings, to write
write_output = (ofile, output, use_temp=true) ->
    text = if type(output) == "table"
            table.concat(output, "\n")
        else
            output
    if ofile == "-"
        print text
    else
        with posix
            fd, name = if use_temp
                .mkstemp "histofile.XXXXXX"
            else
                .open ofile, posix.O_CREAT, "u+w"
            unless fd
                return posix.EIO, name
            .write fd, text
            .close fd
            if use_temp
                res, err = os.rename name, ofile
                unless res
                    return res, err
                .chmod ofile, "u+w"
                os.remove name
    return 0
-- }}}


--- Parse command line arguments.
-- @return Processed command line arguments
parse_args = (using nil) ->
    parser = with argparse NAME, DESCRIPTION,
            "Please report bugs at https://github.com/JNRowe/#{NAME}/issues"

        with \flag "-v --version", "Show the version and exit."
            \action ->
                print "#{NAME}, version #{VERSION.dotted}"
                os.exit 0
        \option "-d --directory", "Location to store history entries.",
            ".histofile"
        \command_target "command"
        \command "list", "List history entries."
        with \command "new", "Add new history entry."
            \argument "entry", "History entry to add."
        with \command "update", "Update history file."
            with \argument "version", "Version number of release."
                \convert => @match "^%d+%.%d+%.%d+$"
            \argument "file", "Location of history file.",
                "NEWS.rst"
            \option "-d --date", "Date of release.",
                os.date "%Y-%m-%d",
                => @match "^%d%d%d%d%-%d%d%-%d%d$"
            with \option "-o --output", "Output file name."
                \argname "<file>"
            \flag "-k --keep",
                "Keep old data files after update (default when writing to stdout)."

    parser\parse!


-- Main commands {{{

commands =
    --- List history entries.
    -- @param args Parsed arguments
    list: (args using nil) ->
        if entries = find_entries args.directory
            for name, entry in pairs entries
                print colourise(entry.time, "magenta"), entry.message
        else
            fail "No entries"
            return posix.ENOENT
        return 0


    --- Add new history entry.
    -- @param args Parsed arguments
    new: (args using nil) ->
        unless posix.stat("#{args.directory}", "type") == "directory"
            posix.mkdir args.directory
        {:sec, :usec} = posix.gettimeofday!
        name = "%s/%s.%06d.json"\format args.directory, os.date("!%s", sec), usec
        if posix.access name
            fail "wowzers, time clash with µsec is some fast history making"
            return posix.EEXIST
        unless write_output(name, dkjson.encode({
                    message: args.entry,
                }, indent: true
            )) == 0
            fail "ick!  Write failure"
            return posix.EIO
        return 0


    --- Update history file.
    -- @param args Parsed arguments
    update: (args using nil) ->
        if entries = find_entries args.directory
            if file = io.open args.file
                marker = find_marker file
                output = build_file file, marker, entries, args.version,
                    args.date
                file\close!
                unless write_output args.output or args.file, output
                    fail "ick!  Write failure"
                    return posix.EIO
                if not args.keep and args.output != "-"
                    for entry in *entries
                        os.remove entry._filename
            else
                unless write_output args.output or args.file,
                    HISTORY_TEMPLATE, false
                    fail "ick!  Write failure"
                    return posix.EIO
        else
            fail "No entries"
            return posix.ENOENT
        return 0
-- }}}


--- Main entry point.
main = (using nil) ->
    posix.signal 2, ->
        -- Make C-c less ugly
        os.exit 255

    args = parse_args!

    os.exit commands[args.command] args

if not package.loaded["busted"]
    main!
else
    :find_entries, :wrap_entry
