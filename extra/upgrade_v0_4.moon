#! /usr/bin/env moon
--
-- Copyright © 2016  James Rowe <jnrowe@gmail.com>
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

NAME = "upgrade_v0_4"
DESCRIPTION = "Upgrade old pre-v0.4 history files"

argparse = require "argparse"
dkjson = require "dkjson"
posix = require "posix"


--- List old history entries.
-- @param path Path to search
-- @return Matching entries
find_entries = (path using nil) ->
    name_to_time = (f) ->
        time = tonumber f\match "/(%d+%.?%d+)%."
        os.date "%Y-%m-%dT%H:%M:%S", time
    files = {}
    if txt_files = posix.glob "#{path}/[0-9][0-9]*[.0-9][0-9]*.txt"
        for f in *txt_files
            with io.open f
                message = \read("*a")
                \close!
                table.insert files, {
                    :message
                    time: name_to_time f
                    filename: f
                }
    if #files == 0
        return nil, "No entries found"
    return files


commands =
    --- List old history entries.
    -- @param args Parsed arguments
    list: (args using nil) ->
        if entries = find_entries args.directory
            for name, entry in pairs entries
                print "#{entry.time}: #{entry.message}"
        else
            print "No entries"
            return posix.ENOENT
        return 0

    --- Update data files.
    -- @param args Parsed arguments
    update: (args using nil) ->
        if entries = find_entries args.directory
            for e in *entries
                print "Converting #{posix.basename e.filename}"
                new_name = e.filename\gsub("%.[^%.]+$", ".json")
                if posix.access new_name
                    print "JSON data file already exists for #{e.filename}"
                    return posix.EEXIST
                with io.open new_name, "w"
                    \write dkjson.encode({
                        message: e.message,
                    }, indent: true)

                if not args.keep
                    os.remove e.filename
        else
            print "No entries"
            return posix.ENOENT
        return 0


parser = with argparse NAME, DESCRIPTION,
        "Please report bugs at https://github.com/JNRowe/#{NAME}/issues"

    \option "-d --directory", "Location to store history entries.",
        ".histofile"
    \command_target "command"
    \command "list", "List history entries."
    with \command "update", "Update history file."
        \flag "-k --keep",
            "Keep old data files after upgrade."

if not package.loaded["busted"]
    args = parser\parse!
    os.exit commands[args.command] args
else
    :find_entries
