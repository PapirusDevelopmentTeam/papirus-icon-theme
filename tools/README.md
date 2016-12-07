# Tools

* `run_on_dirs.sh DIRECTORY...` — optimizes and fixes SVG files in the directory
* `run_on_files.sh FILE...` — optimizes and fixes the SVG files
* `_fix_color_scheme.sh FILE...` — looks in the SVG files for certain colors and replaces them with the corresponding stylesheet class. Fixes the color scheme after Inkscape
* `svgo.yml` — [SVGO](https://github.com/svg/svgo) configuraion


## Useful snippets

Optimize and fix SVG files that are added or modified but not committed (recommended)

```
git status --porcelain | awk '/A|M/{print $2}' | xargs ./tools/run_on_files.sh
```

Optimize and fix SVG files that are committed in [043906b](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme/commit/043906b0edbcc86b732640bc391898d0aaaa410c)

```
git show --name-only 043906b | xargs ./tools/run_on_files.sh
```
