PREFIX ?= /usr

all:

install:
	mkdir -p $(DESTDIR)$(PREFIX)/share/icons
	cp -r ePapirus Papirus Papirus-Light Papirus-Dark \
		$(DESTDIR)$(PREFIX)/share/icons

post-install:
	-gtk-update-icon-cache -q $(DESTDIR)$(PREFIX)/share/icons/ePapirus
	-gtk-update-icon-cache -q $(DESTDIR)$(PREFIX)/share/icons/Papirus
	-gtk-update-icon-cache -q $(DESTDIR)$(PREFIX)/share/icons/Papirus-Dark
	-gtk-update-icon-cache -q $(DESTDIR)$(PREFIX)/share/icons/Papirus-Light

uninstall:
	-rm -rf $(DESTDIR)$(PREFIX)/share/icons/ePapirus
	-rm -rf $(DESTDIR)$(PREFIX)/share/icons/Papirus
	-rm -rf $(DESTDIR)$(PREFIX)/share/icons/Papirus-Dark
	-rm -rf $(DESTDIR)$(PREFIX)/share/icons/Papirus-Light

_get_version:
	$(eval VERSION := $(shell git show -s --format=%cd --date=format:%Y%m%d HEAD))
	@echo $(VERSION)

push:
	git push origin

release: _get_version push
	git tag -f $(VERSION)
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
	cp -f Papirus/AUTHORS ePapirus/AUTHORS
	cp -f Papirus/AUTHORS Papirus-Dark/AUTHORS
	cp -f Papirus/AUTHORS Papirus-Light/AUTHORS


.PHONY: all install uninstall _get_version push release undo_release tests update_authors
