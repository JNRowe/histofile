import wrap_entry from require "histofile"

-- http://en.wikipedia.org/wiki/Lorem_ipsom
lorem = (
    "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do " ..
    "eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim " ..
    "ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut " ..
    "aliquip ex ea commodo consequat. Duis aute irure dolor in " ..
    "reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla " ..
    "pariatur. Excepteur sint occaecat cupidatat non proident, sunt in " ..
    "culpa qui officia deserunt mollit anim id est laborum."
)

split = (s, delim="\n") ->
    [b for b in s\gmatch "([^#{delim}]*)#{delim}?"]


describe "wrap_entry", ->
    it "works on single lines", ->
        assert.same wrap_entry("test"), "test"

    it "works on looong lines", ->
        assert.equals #split(wrap_entry(lorem)), 8

    it "works with varying width", ->
        assert.same wrap_entry("this is a test string", 20),
            "this is a test\nstring"

        for w = 10, 100, 5
            assert.is_true #split(wrap_entry(lorem, w), "\n")[1] <= w

    it "supports setting initial indent", ->
        assert.same wrap_entry("test", 72, "  "), "  test"

    it "supports differing indent for first line", ->
        assert.same wrap_entry("this is a test string", 20, "  ", ""),
            "  this is a test\nstring"

    it "defaults subsequent indent to initial indent", ->
        assert.same wrap_entry("this is a test string", 20, "  "),
            "  this is a test\n  string"
