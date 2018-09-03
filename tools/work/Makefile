THEMES_DIR := ../..
THEMES := $(patsubst %/index.theme,%,$(wildcard $(THEMES_DIR)/*/index.theme))

all:

clean:
	@bash ./clean.sh

convert:
	@bash ./convert.sh

prepare:
	@bash ./prepare.sh

put:
	@bash ./put-into-theme.sh

tests:
	# >>> TEST 1: Searching for icons with renderer issues
	-@LC_ALL=C egrep -rl --include='*.svg' \
		-e 'd="[a-zA-Z0-9 -.]+-\.[a-zA-Z0-9 -.]+"' \
		-e 'd="[a-zA-Z0-9 -.]+\s\.[a-zA-Z0-9 -.]+"' \
		$(THEMES) || true
	# >>> TEST 2: Searching for icons with bitmap images
	-@LC_ALL=C egrep -rl --include='*.svg' \
		-e '<image[ ]' \
		$(THEMES) || true
	# >>> TEST 3: Searching for broken symlinks
	-@find $(THEMES) -xtype l -print
	# --- TESTS COMPLETED ---

.PHONY: all clean convert prepare put tests

# allows to run goals from the main Makefile
.PHONY: install uninstall dist release undo_release
install uninstall dist release undo_release:
	$(MAKE) -C "$(THEMES_DIR)" $@
