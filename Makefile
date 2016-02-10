SOURCES ::= $(wildcard *.moon)
TARGETS ::= $(SOURCES:.moon=.lua)
RST_SOURCES ::= $(wildcard *.rst)
RST_TARGETS ::= $(RST_SOURCES:.rst=.html)

MOONC ::= moonc
RST2HTML ::= rst2html.py
SPHINXBUILD ::= sphinx-build

.PHONY: check clean display_sources doc lint sphinxdoc sphinxbuilder

all: $(TARGETS)

doc: $(RST_TARGETS)

sphinxdoc: SPHINXBUILDER=html
sphinxdoc: sphinxbuilder

$(TARGETS): %.lua: %.moon
	$(MOONC) $<

$(RST_TARGETS): %.html: %.rst
	$(RST2HTML) --strict $< $@

sphinxbuilder:
	$(SPHINXBUILD) $(SPHINXEXTRAOPTS) -b $(SPHINXBUILDER) \
		-d doc/_build/doctrees doc/ doc/_build/$(SPHINXBUILDER)

clean:
	rm -f $(TARGETS) $(RST_TARGETS)

display_sources:
	@echo $(realpath $(SOURCES))

lint:
	$(MOONC) -l $(SOURCES)

check: SPHINXBUILDER=spelling
check: SPHINXEXTRAOPTS=-W
check: lint sphinxbuilder
