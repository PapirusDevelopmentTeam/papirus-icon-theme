ROOT := ../..
THEMES := $(patsubst %/index.theme,%,$(wildcard $(ROOT)/*/index.theme))

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
		"$(ROOT)" || true
	# >>> TEST 2: Searching for icons with bitmap images
	-@LC_ALL=C egrep -rl --include='*.svg' \
		-e '<image[ ]' \
		"$(ROOT)" || true
	# >>> TEST 3: Searching for broken symlinks
	-@find "$(ROOT)" -xtype l -not -path '$(ROOT)/tools/*' -print
	# --- TEST COMPLETED ---

update_authors:
	editor "$(ROOT)/Papirus/AUTHORS"
	@for i in $(THEMES); do \
		[ $$i != "$(ROOT)/Papirus" ] || continue; \
		cp -vf "$(ROOT)/Papirus/AUTHORS" "$$i/"; \
	done

.PHONY: all clean convert prepare put tests update_authors

# allows to run goals from the main Makefile
.PHONY: install uninstall dist release undo_release
install uninstall dist release undo_release:
	$(MAKE) -C "$(ROOT)" $@
