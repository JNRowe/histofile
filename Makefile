PREFIX ::= /usr
BINDIR ::= $(PREFIX)/bin
MANDIR ::= $(PREFIX)/share/man
SHAREDIR ::= $(PREFIX)/share/histofile

TEMPLATES ::= $(wildcard templates/*)

SOURCES ::= $(wildcard *.moon extra/*.moon)
TARGETS ::= $(SOURCES:.moon=.lua)
RST_SOURCES ::= $(wildcard *.rst)
RST_TARGETS ::= $(RST_SOURCES:.rst=.html)

MOONC != which moonc
RST2HTML != which rst2html.py
SPHINXBUILD != which sphinx-build

.PHONY: check clean display_sources dist doc lint sphinxdoc sphinxbuilder

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
	$(RM) $(TARGETS) $(RST_TARGETS)

display_sources:
	@echo $(realpath $(SOURCES))

lint: lint_config.lua
	$(info - Linting moonscript files)
	$(MOONC) -l $(SOURCES)

check: SPHINXBUILDER=spelling
check: SPHINXEXTRAOPTS=-W -n
check: lint sphinxbuilder

dist:
	$(info - Generating tarballs)
	mkdir -p dist/
	version=$(shell git describe); \
	arcname=histofile-$${version#v}; \
	tarname=$$arcname.tar; \
	git archive -o dist/$$tarname --prefix=$$arcname/ $$version; \
	cd dist/; \
	gzip -9 < $$tarname >|$$tarname.gz; \
	bzip2 -9 < $$tarname >|$$tarname.bz2; \
	xz -9 < $$tarname >|$$tarname.xz; \
	$(RM) $$tarname
