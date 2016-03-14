PREFIX ::= /usr
BINDIR ::= $(PREFIX)/bin
MANDIR ::= $(PREFIX)/share/man
SHAREDIR ::= $(PREFIX)/share/histofile

TEMPLATES ::= $(wildcard templates/*)

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

.INTERMEDIATE: histofile
histofile: histofile.moon
	$(info - Generating $@)
	sed \
	    -e '/^VERSION =/c VERSION = $(shell sed '1d;$$!s,$$,\\,' version.moon)' \
	    -e '/^-- BEGIN PKG_PATH/,/^-- END PKG_PATH/cPKG_PATH = "$(SHAREDIR)"' \
	    $< | moonc -- \
	    | sed '1i #! /usr/bin/env lua' >$@
	chmod 755 $@

install: SPHINXBUILDER=man
install: histofile sphinxbuilder
	$(info - Installing to [$(DESTDIR)]$(PREFIX))
	install -d $(DESTDIR)$(BINDIR)
	install histofile $(DESTDIR)$(BINDIR)
	install -d $(DESTDIR)$(SHAREDIR)
	for tmpl in $(TEMPLATES); do \
	    install -d $(DESTDIR)$(SHAREDIR)/$${tmpl}; \
	    install -m644 $$tmpl/*.etlua $$tmpl/marker $(DESTDIR)$(SHAREDIR)/$${tmpl}; \
	done
	install -d $(DESTDIR)/$(MANDIR)/man1
	install -m644 doc/_build/man/histofile.1 $(DESTDIR)/$(MANDIR)/man1

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
