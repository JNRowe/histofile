import colourise from require "histofile"

describe "colourise", ->
    it "supports pass through", ->
        assert.equals colourise("test"), "test"

    it "supports basic colourisation", ->
        assert.equals colourise("test", "green", {}, true)\sub(1, 5),
            "\027[32m"

    it "supports basic bolding", ->
        assert.equals colourise("test", nil, {bold: true}, true)\sub(1, 4),
            "\027[1m"

    it "supports basic underlining", ->
        assert.equals colourise("test", nil, {underline: true}, true)\sub(1, 4),
            "\027[4m"

    it "supports bold colourisation", ->
        out = colourise("test", "red", {bold: true}, true)
        assert.equals out\sub(1, 5), "\027[31m"
        assert.equals out\sub(6, 9), "\027[1m"

    it "supports bold underlining", ->
        out = colourise("test", nil, {bold: true, underline: true}, true)
        assert.equals out\sub(1, 4), "\027[1m"
        assert.equals out\sub(5, 8), "\027[4m"
