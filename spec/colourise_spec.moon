import stylise from require "histofile"

describe "stylise", ->
    it "supports pass through", ->
        assert.equals stylise("test"), "test"

    it "supports basic colourisation", ->
        assert.equals stylise("test", "green", {}, true)\sub(1, 5),
            "\027[32m"

    it "supports basic bolding", ->
        assert.equals stylise("test", nil, {bold: true}, true)\sub(1, 4),
            "\027[1m"

    it "supports basic underlining", ->
        assert.equals stylise("test", nil, {underline: true}, true)\sub(1, 4),
            "\027[4m"

    it "supports bold colourisation", ->
        out = stylise("test", "red", {bold: true}, true)
        assert.equals out\sub(1, 5), "\027[31m"
        assert.equals out\sub(6, 9), "\027[1m"

    it "supports bold underlining", ->
        out = stylise("test", nil, {bold: true, underline: true}, true)
        assert.equals out\sub(1, 4), "\027[1m"
        assert.equals out\sub(5, 8), "\027[4m"
