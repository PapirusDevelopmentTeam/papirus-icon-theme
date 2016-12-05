# Tools

* `run_on_all.sh` — optimize and fix all SVG files in the repository
* `run_on_dirs.sh DIRECTORY...` — optimize and fix SVG files in the directory
* `run_on_files.sh FILE...` — optimize and fix the SVG files
* `_fix_color_scheme.sh FILE...` — remove a color property from `style="color:#5c616c;fill:currentColor;opacity:1"` if class `ColorScheme-*` exists
* `svgo.yml` — [SVGO](https://github.com/svg/svgo) configuraion


## Useful snippets

Optimize and fix SVG files that are changed but not committed

```
git diff --name-only | xargs ./tools/run_on_files.sh
```

Optimize and fix SVG files that are committed in 043906b

```
git show --name-only 043906b | xargs ./tools/run_on_files.sh
```
