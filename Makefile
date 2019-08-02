# GNU make is required to run this file. To install on *BSD, run:
#   gmake PREFIX=/usr/local install

PREFIX ?= /usr
ICON_THEMES ?= $(patsubst %/index.theme,%,$(wildcard ./*/index.theme))
IGNORE ?=

# excludes IGNORE from ICON_THEMES list
ICON_THEMES := $(filter-out $(IGNORE), $(ICON_THEMES))

all:

install:
	mkdir -p $(DESTDIR)$(PREFIX)/share/icons
	cp -R $(ICON_THEMES) $(DESTDIR)$(PREFIX)/share/icons

# skip building icon caches when packaging
	$(if $(DESTDIR),,$(MAKE) $(ICON_THEMES))

$(ICON_THEMES):
	-gtk-update-icon-cache -q $(DESTDIR)$(PREFIX)/share/icons/$@

uninstall:
	-rm -rf $(foreach icon_theme,$(ICON_THEMES),$(DESTDIR)$(PREFIX)/share/icons/$(icon_theme))

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
test_short: test_renderer test_svg_elems test_symlinks test_filenames

.PHONY: test_long
test_long: test_xml_struct

.PHONY: test_renderer
test_renderer:
	# >>> Searching for icons with renderer bugs
	@! LC_ALL=C grep -E -rl --include='*.svg' \
		-e 'd="[a-zA-Z0-9 -.]+-\.[a-zA-Z0-9 -.]+"' \
		-e 'd="[a-zA-Z0-9 -.]+\s\.[a-zA-Z0-9 -.]+"' \
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
	# >>> Searching for invalid filenames
	@LC_ALL=C find $(ICON_THEMES) -not -iregex '[-_/\.+@a-z0-9]+' -print \
		-exec false '{}' +

.PHONY: test_xml_struct
test_xml_struct:
	# >>> Searching for broken SVG icons
	@find $(ICON_THEMES) -type f -name '*.svg' \
		-exec xmlstarlet validate --list-bad '{}' +

# .BEGIN is ignored by GNU make so we can use it as a guard
.BEGIN:
	@head -3 Makefile
	@false
