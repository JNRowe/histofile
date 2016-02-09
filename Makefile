SOURCES ::= $(wildcard *.moon)
TARGETS ::= $(SOURCES:.moon=.lua)
RST_SOURCES ::= $(wildcard *.rst)
RST_TARGETS ::= $(RST_SOURCES:.rst=.html)

MOONC ::= moonc
RST2HTML ::= rst2html.py

.PHONY: clean display_sources doc

all: $(TARGETS)

doc: $(RST_TARGETS)

$(TARGETS): %.lua: %.moon
	$(MOONC) $<

$(RST_TARGETS): %.html: %.rst
	$(RST2HTML) --strict $< $@

clean:
	rm -f $(TARGETS) $(RST_TARGETS)

display_sources:
	@echo $(realpath $(SOURCES))
