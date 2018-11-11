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

test-render-issues:
	# >>> Searching for icons with render issues
	@! LC_ALL=C grep -E -rl --include='*.svg' \
		-e 'd="[a-zA-Z0-9 -.]+-\.[a-zA-Z0-9 -.]+"' \
		-e 'd="[a-zA-Z0-9 -.]+\s\.[a-zA-Z0-9 -.]+"' \
		$(THEMES)

test-bitmap-images:
	# >>> Searching for icons with bitmap images
	@! LC_ALL=C grep -E -rl --include='*.svg' \
		-e '<image[ ]' \
		$(THEMES)

test-broken-symlinks:
	# >>> Searching for broken symlinks
	@find $(THEMES) -xtype l -printf '%p -> %l\n' -exec false '{}' +

test-invalid-filenames:
	# >>> Searching for invalid filenames
	@find $(THEMES) -not -iregex '.*/[-_\.+@a-z0-9]*' -print \
		-exec false '{}' +

test: test-render-issues test-bitmap-images test-broken-symlinks test-invalid-filenames

validate:
	# >>> Validate SVG files (the process takes a long time)
	@find $(THEMES) -type f -name '*.svg' \
		-exec xmlstarlet validate --list-bad '{}' +

.PHONY: all clean convert prepare put test validate

# allows to run goals from the main Makefile
.PHONY: install uninstall dist release undo_release
install uninstall dist release undo_release:
	$(MAKE) -C "$(THEMES_DIR)" $@
