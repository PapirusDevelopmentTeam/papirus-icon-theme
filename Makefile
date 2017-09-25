# GNU make is required to run this file. To install on *BSD, run:
#   gmake PREFIX=/usr/local install

PREFIX ?= /usr
IGNORE ?=
THEMES ?= ePapirus Papirus Papirus-Adapta Papirus-Adapta-Nokto Papirus-Dark Papirus-Light

# excludes IGNORE from THEMES list
THEMES := $(filter-out $(IGNORE), $(THEMES))

all:

install:
	mkdir -p $(DESTDIR)$(PREFIX)/share/icons
	cp -R $(THEMES) $(DESTDIR)$(PREFIX)/share/icons

# skip building icon caches when packaging
	$(if $(DESTDIR),,$(MAKE) $(THEMES))

$(THEMES):
	-gtk-update-icon-cache -q $(DESTDIR)$(PREFIX)/share/icons/$@

uninstall:
	-rm -rf $(foreach theme,$(THEMES),$(DESTDIR)$(PREFIX)/share/icons/$(theme))

_get_version:
	$(eval VERSION := $(shell git show -s --format=%cd --date=format:%Y%m%d HEAD))
	@echo $(VERSION)

dist: _get_version
	git archive --format=tar.gz -o $(notdir $(CURDIR))-$(VERSION).tar.gz master -- $(THEMES)

release: _get_version
	git tag -f $(VERSION)
	git push origin
	git push origin --tags

undo_release: _get_version
	-git tag -d $(VERSION)
	-git push --delete origin $(VERSION)

tests:
	# <<< TEST 1: Searching for icons with renderer issues
	-@LC_ALL=C egrep -rl --include='*.svg' \
		-e 'd="[a-zA-Z0-9 -.]+-\.[a-zA-Z0-9 -.]+"' \
		-e 'd="[a-zA-Z0-9 -.]+\s\.[a-zA-Z0-9 -.]+"' \
		|| true
	# >>> TEST 1: END
	# <<< TEST 2: Searching for icons with bitmap images
	-@LC_ALL=C egrep -rl --include='*.svg' \
		-e '<image[ ]' \
		|| true
	# >>> TEST 2: END
	# <<< TEST 3: Searching for broken symlinks
	-@find . -xtype l -not -path './tools/*' -print
	# >>> TEST 3: END

update_authors:
	editor Papirus/AUTHORS
	@echo $(THEMES) | xargs -n 1 cp -vu Papirus/AUTHORS || true


.PHONY: $(THEMES) all install uninstall _get_version dist release undo_release tests update_authors

# .BEGIN is ignored by GNU make so we can use it as a guard
.BEGIN:
	@head -3 Makefile
	@false
