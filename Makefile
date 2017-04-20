all:

install:
	mkdir -p $(DESTDIR)/usr/share/icons
	cp --no-preserve=mode,ownership -r \
		Pop \
		$(DESTDIR)/usr/share/icons

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
	# Printing all broken symlinks
	@find . -xtype l -not -path './tools/work/*' -print


.PHONY: all install uninstall _get_version push release undo_release tests
