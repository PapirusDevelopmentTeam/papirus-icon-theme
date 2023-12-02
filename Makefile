# GNU make is required to run this file. To install on *BSD, run:
#   gmake PREFIX=/usr/local install

PREFIX ?= /usr
ICON_THEMES ?= $(patsubst %/index.theme,%,$(wildcard */index.theme))
EXCLUDE ?=
CP_OPTS ?=

# exclude icon theme(s) from ICON_THEMES list
ICON_THEMES := $(filter-out $(EXCLUDE), $(ICON_THEMES))

all:

install:
	mkdir -p "$(DESTDIR)$(PREFIX)/share/icons"
	cp -R $(CP_OPTS) -- $(ICON_THEMES) "$(DESTDIR)$(PREFIX)/share/icons"

# skip building icon caches when packaging
	$(if $(DESTDIR),,$(MAKE) $(ICON_THEMES))

$(ICON_THEMES):
	-gtk-update-icon-cache -q "$(DESTDIR)$(PREFIX)/share/icons/$@"

uninstall:
	-rm -rf $(foreach icon_theme,$(ICON_THEMES),"$(DESTDIR)$(PREFIX)/share/icons/$(icon_theme)")

_get_version:
	$(eval VERSION := $(shell git show -s --format=%cd --date=format:%Y%m%d HEAD))
	@echo $(VERSION)

dist: _get_version
	git archive --format=tar.gz -o $(notdir $(CURDIR))-$(VERSION).tar.gz master -- $(ICON_THEMES)

release: _get_version
	git tag -f $(VERSION)
	git push origin
	git push origin --tags

undo_release: _get_version
	-git tag -d $(VERSION)
	-git push --delete origin $(VERSION)

clean_themes:
	-git clean -i $(ICON_THEMES)


.PHONY: $(ICON_THEMES) all install uninstall _get_version dist release undo_release clean_themes

# TESTS
.PHONY: test
test: test_short

.PHONY: test-all
test-all: test_short test_long

.PHONY: test_short
test_short: test_rendering_glitches test_optimization test_svg_elems test_symlinks test_filenames test_decimal_size test_lengths_units

.PHONY: test_long
test_long: test_xml_struct

.PHONY: test_rendering_glitches
test_rendering_glitches:
	# >>> Searching for icons with rendering glitches
	@! LC_ALL=C grep -E -rl --include='*.svg' \
		-e 'd="[a-zA-Z0-9 -.]+-\.[a-zA-Z0-9 -.]+"' \
		-e 'd="[a-zA-Z0-9 -.]+\s\.[a-zA-Z0-9 -.]+"' \
		$(ICON_THEMES)

.PHONY: test_decimal_size
test_decimal_size:
	# >>> Detecting decimal numbers in width/height/viewBox attrs
	@! LC_ALL=C grep -E -rl --include='*.svg' \
		-e '<svg[ ].*(width|height)="[0-9]+\.[0-9]*"' \
		-e '<svg[ ].*viewBox="0 0 [0-9]+\.[0-9]+ [0-9]+(|\.[0-9]+)"' \
		-e '<svg[ ].*viewBox="0 0 [0-9]+(|\.[0-9]+) [0-9]+\.[0-9]+"' \
		$(ICON_THEMES)

.PHONY: test_lengths_units
test_lengths_units:
	# >>> Detecting lengths units
	@! LC_ALL=C grep -E -rl --include='*.svg' \
		-e '<svg[ ].*(width|height|viewBox)="[0-9]+(|\.[0-9]*)[a-z]+' \
		$(ICON_THEMES)

.PHONY: test_optimization
test_optimization:
	# >>> Searching for non-optimized icons
	@! LC_ALL=C grep -E -rl --include='*.svg' \
		-e '^<\?xml' \
		$(ICON_THEMES)

.PHONY: test_svg_elems
test_svg_elems:
	# >>> Searching for icons with embedded objects
	@! LC_ALL=C grep -E -rl --include='*.svg' \
		-e '<image[ ]' \
		-e '<object[ ]' \
		$(ICON_THEMES)

.PHONY: test_symlinks
test_symlinks:
	# >>> Searching for broken symlinks
	@find $(ICON_THEMES) -xtype l -printf '%p -> %l\n' -exec false '{}' +

.PHONY: test_filenames
test_filenames:
	# >>> Searching for invalid icon names
	@LC_ALL=C find $(ICON_THEMES) -not -iregex '[-_/\.+@a-z0-9]+' -print \
		-exec false '{}' +

.PHONY: test_xml_struct
test_xml_struct:
	# >>> Searching for non-valid SVG files
	@find $(ICON_THEMES) -type f -name '*.svg' \
		-exec xmlstarlet validate --list-bad '{}' +

# .BEGIN is ignored by GNU make so we can use it as a guard
.BEGIN:
	@head -3 Makefile
	@false
