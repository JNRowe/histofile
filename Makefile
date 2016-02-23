SOURCES ::= $(wildcard *.moon)
TARGETS ::= $(SOURCES:.moon=.lua)
RST_SOURCES ::= $(wildcard *.rst)
RST_TARGETS ::= $(RST_SOURCES:.rst=.html)

MOONC ::= $(shell which moonc)
RST2HTML ::= $(shell which rst2html.py)
SPHINXBUILD ::= $(shell which sphinx-build)

.PHONY: check clean display_sources doc lint sphinxdoc sphinxbuilder

ifndef VERBOSE
.SILENT:
endif

all: $(TARGETS)

doc: $(RST_TARGETS)

sphinxdoc: SPHINXBUILDER=html
sphinxdoc: sphinxbuilder

$(TARGETS): %.lua: %.moon
	$(info - Generating $@)
	$(MOONC) $<

$(RST_TARGETS): %.html: %.rst
	$(info - Generating $@)
	$(RST2HTML) --strict $< $@

sphinxbuilder:
	$(info - Running sphinx with $(SPHINXBUILDER) builder)
	$(SPHINXBUILD) $(SPHINXEXTRAOPTS) -b $(SPHINXBUILDER) \
		-d doc/_build/doctrees doc/ doc/_build/$(SPHINXBUILDER)

clean:
	$(info - Cleaning generated files)
	rm -f $(TARGETS) $(RST_TARGETS)

display_sources:
	@echo $(realpath $(SOURCES))

lint: lint_config.lua
	$(info - Linting moonscript files)
	$(MOONC) -l $(SOURCES)

check: SPHINXBUILDER=spelling
check: SPHINXEXTRAOPTS=-W
check: lint sphinxbuilder
