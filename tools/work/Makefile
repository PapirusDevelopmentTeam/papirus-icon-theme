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

test:
	# >>> Searching for icons with renderer issues
	-@LC_ALL=C egrep -rl --include='*.svg' \
		-e 'd="[a-zA-Z0-9 -.]+-\.[a-zA-Z0-9 -.]+"' \
		-e 'd="[a-zA-Z0-9 -.]+\s\.[a-zA-Z0-9 -.]+"' \
		$(THEMES) || true
	# >>> Searching for icons with bitmap images
	-@LC_ALL=C egrep -rl --include='*.svg' \
		-e '<image[ ]' \
		$(THEMES) || true
	# >>> Searching for broken symlinks
	-@find $(THEMES) -xtype l -print
	# >>> Searching for invalid filenames
	-@find $(THEMES) -not -iregex '.*/[-_\.+@a-z0-9]*' -print
	# --- TEST COMPLETED ---

validate:
	# >>> Validate SVG files (the process takes a long time)
	-@find $(THEMES) -type f -name '*.svg' \
		-exec xmlstarlet validate --list-bad '{}' \;
	# --- VALIDATE COMPLETED ---

.PHONY: all clean convert prepare put test validate

# allows to run goals from the main Makefile
.PHONY: install uninstall dist release undo_release
install uninstall dist release undo_release:
	$(MAKE) -C "$(THEMES_DIR)" $@
