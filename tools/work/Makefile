THEMES_DIR := ../..

all:

clean:
	@bash ./clean.sh

convert:
	@bash ./convert.sh

prepare:
	@bash ./prepare.sh

put:
	@bash ./put-into-theme.sh

.PHONY: all clean convert prepare put

# allows to run goals from the main Makefile
.PHONY: install uninstall dist release undo_release test test-all clean_themes
install uninstall dist release undo_release test test-all clean_themes:
	$(MAKE) -C "$(THEMES_DIR)" $@
