all:
	#"There is no need to run 'make'. Just run 'sudo make install'"

install:
	mkdir -p $(DESTDIR)/usr/share/icons/Pop
	cp --no-preserve=mode,ownership -r \
		Papirus/* \
		$(DESTDIR)/usr/share/icons/Pop
	cp --no-preserve=mode,ownership -r \
	    Pop\ Overrides/* \
	    $(DESTDIR)/usr/share/icons/Pop
	./icons-recolor.sh $(DESTDIR)/usr/share/icons/Pop/

post-install:
	-gtk-update-icon-cache -q $(DESTDIR)/usr/share/icons/Pop

uninstall:
	-rm -rf $(DESTDIR)/usr/share/icons/Pop

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
